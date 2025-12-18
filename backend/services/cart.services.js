const {cart}=require("../models/cart.model");
var async= require("async");

// async function addCart(params, callback) {
//     try {
//         if (!params.userId) {
//             return callback({ message: "UserId Required" });
//         }

//         let cartDB = await cart.findOne({ userId: params.userId }); // ✅ Use `await`

//         if (!cartDB) {
//             const cartModel = new cart({
//                 userId: params.userId,
//                 products: params.products
//             });

//             const savedCart = await cartModel.save(); // ✅ Save the new cart
//             return callback(null, savedCart);
//         }

//         if (cartDB.products.length === 0) {
//             cartDB.products = params.products;
//             await cartDB.save(); // ✅ Save updated cart
//             return callback(null, cartDB);
//         } else {
//             // ✅ Fix async.eachSeries (convert to for-loop for async/await support)
//             for (const product of params.products) {
//                 let itemIndex = cartDB.products.findIndex(p => p.product.toString() === product.product);
                
//                 if (itemIndex === -1) {
//                     cartDB.products.push({
//                         product: product.product,
//                         qty: product.qty
//                     });
//                 } else {
//                     cartDB.products[itemIndex].qty += product.qty;
//                 }
//             }

//             await cartDB.save(); // ✅ Save the updated cart
//             return callback(null, cartDB);
//         }
//     } catch (error) {
//         return callback(error);
//     }
// }/

    async function addCart(params, callback) {
        try {
            if (!params.userId) {
                return callback({ message: "UserId Required" });
            }

            let cartDB = await cart.findOne({ userId: params.userId });

            if (!cartDB) {
                const cartModel = new cart({
                    userId: params.userId,
                    products: params.products
                });

                const savedCart = await cartModel.save();
                return callback(null, savedCart);
            }

            if (!Array.isArray(cartDB.products)) {
                cartDB.products = [];
            }

            for (const product of params.products) {
                const index = cartDB.products.findIndex(
                    (p) => p.product.toString() === product.product
                );

                if (index === -1) {
                    cartDB.products.push({
                        product: product.product,
                        qty: product.qty
                    });
                } else {
                    cartDB.products[index].qty += product.qty;
                }
            }

            const updatedCart = await cartDB.save();
            return callback(null, updatedCart);
        } catch (error) {
            return callback(error);
        }
    }


async function getCart(params, callback){
    cart.findOne({
        userId:params.userId
    }).populate({
        path:"products",
        populate:{
            path:'product',
            model:'Product',
            select: 'productName productPrice, productSalePrice productImage',
            populate:{
                path:'category',
                model:'Category',
                select:'categoryName'
            }
        }
    })
    .then((response)=>{
        return callback(null,response);
    })
    .catch((error)=>{
        return callback(error);
    });
}

async function removeCartItem(params, callback) {
    try {
        const cartDB = await cart.findOne({ userId: params.userId });

        if (!cartDB || cartDB.products.length === 0) {
            return callback(null, "Cart Empty!");
        }

        const productId = params.productId;
        const qty = params.qty;

        const itemIndex = cartDB.products.findIndex(p => p.product == productId);

        if (itemIndex === -1) {
            return callback(null, "Invalid Product!");
        }

        if (cartDB.products[itemIndex].qty === qty) {
            cartDB.products.splice(itemIndex, 1);
        } else if (cartDB.products[itemIndex].qty > qty) {
            cartDB.products[itemIndex].qty -= qty;
        } else {
            return callback(null, "Enter lower Qty");
        }

        await cartDB.save();
        return callback(null, "Cart Updated!");
    } catch (err) {
        return callback(err);
    }
}


module.exports={
    addCart,
    getCart,
    removeCartItem
}

