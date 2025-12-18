const { user } = require('../models/user.model');
const { cards } = require('../models/cards.model');
const { order } = require('../models/order.model');

const stripeService = require('../services/stripe.service');
const cartService = require('../services/cart.services');
const { cart } = require('../models/cart.model');
const { model } = require('mongoose');

async function createOrder(params) {
    try {
        const userDB = await user.findById(params.userId);
        console.log("📌 createOrder: params.userId =", params.userId);
        console.log("📌 createOrder: userDB =", userDB);


        if (!userDB) throw new Error('User not found');

        const model = {};

        // ✅ 1. Create Stripe customer if needed
        if (!userDB.stripeCustomerId) {
            const customer = await stripeService.createCustomer({
                name: userDB.fullName,
                email: userDB.email,
            });

            userDB.stripeCustomerId = customer.id;
            await userDB.save();
            model.stripeCustomerID = customer.id;
        } else {
            model.stripeCustomerID = userDB.stripeCustomerId;
        }

        // ✅ 2. Find existing card
        const cardDB = await cards.findOne({
            customerId: model.stripeCustomerID,
            cardNumber: params.card_Number,
            cardExpMonth: params.card_ExpMonth,
            cardExpYear: params.card_ExpYear,
        });


        if (!cardDB) {
            const newCard = await stripeService.addCard({
                card_Name: params.card_Name,
                card_Number: params.card_Number,
                card_ExpMonth: params.card_ExpMonth,
                card_ExpYear: params.card_ExpYear,
                card_CVC: params.card_CVC,
                customer_Id: model.stripeCustomerID,
            });


            const cardModel = new cards({
                cardId: newCard.card,
                cardName: params.card_Name,
                cardNumber: params.card_Number,
                cardExpMonth: params.card_ExpMonth,
                cardExpYear: params.card_ExpYear,
                cardCVC: params.card_CVC,
                customerId: model.stripeCustomerID,
            });

            await cardModel.save();
            model.cardId = newCard.card;
        } else {
            model.cardId = cardDB.cardId;
        }

        // ✅ 3. Create Stripe payment intent
        const paymentIntent = await stripeService.generatePaymentIntent({
            receipt_email: userDB.email,
            amount: params.amount,
            card_id: model.cardId,
            customer_id: model.stripeCustomerID,
        });

        model.paymentIntentId = paymentIntent.id;
        model.client_secret = paymentIntent.client_secret;

        // ✅ 4. Get cart
        const cartDB = await cartService.getCart({ userId: userDB._id.toString() });
        if (!cartDB || cartDB.products.length === 0) {
            throw new Error("Cart is empty or not found");
        }

        let orderProducts = [];
        let grandTotal = 0;

        for (const item of cartDB.products) {
            orderProducts.push({
                product: item.product._id,
                qty: item.qty,
                amount: item.product.productSalePrice,
            });

            grandTotal += item.product.productSalePrice * item.qty;
        }

        // ✅ 5. Create order
        const orderModel = new order({
            userId: cartDB.userId,
            products: orderProducts,
            orderStatus: 'Pending',
            grandTotal: grandTotal,
        });

        const orderResult = await orderModel.save();
        model.orderId = orderResult._id;

        return model; // Return model as the result
    } catch (error) {
        throw error; // Rethrow the error to be caught in the controller
    }
}



// async function createOrder(params, callback) {
//     user.findOne({_id:params.userId}, async function(err, userDB){
//         if (err) {
//             return callback(err);
//         }else{
//             var model={};
//             if(!userDB.stripeCustomerId){
//                 await stripeService.createCustomer({
//                     name: userDB.fullName,
//                     email: userDB.email,
//                 },(error, results)=>{
//                     if(error){
//                         return callback(error);
//                     }if(results){
//                         userDB.stripeCustomerId=results.id;
//                         userDB.save();
//                         model.stripeCustomerID=results.id;
//                     }
//                 });
//             }
//             else{
//                 model.stripeCustomerID=userDB.stripeCustomerID;
//             }
//             cards.findOne({
//                 customerId:model.stripeCustomerID,
//                 cardNumber:params.cardNumber,
//                 cardExpMonth:params.cardExpMonth,
//                 cardExpYear:params.cardExpYear,
//             },async function(err, cardDB){
//                 if(err){
//                     return callback(err);
//                 }else{
//                     if(!cardDB){
//                         await stripeService.addCard({
//                             card_Name:params.card_Name,
//                             card_Number:params.card_Number,
//                             card_ExpMonth:params.card_ExpMonth,
//                             card_ExpYear:params.cardExp_Year,
//                             card_CVC:params.card_CVC,
//                             customer_Id:model.stripeCustomerID,
//                         },(error, results)=>{
//                             if(error){
//                                 return callback(error);
//                             }if(results){
//                                 const cardModel=new cards({
//                                     cardId:results.card,
//                                     cardName:params.card_Name,
//                                     cardNumber:params.card_Number,
//                                     cardExpMonth:params.card_ExpMonth,
//                                     cardExpYear:params.card_ExpYear,
//                                     cardCVC:params.card_CVC,
//                                     customerId:model.stripeCustomerID,
//                                 });
//                                 cardModel.save();
//                                 model.cardId=results.card;

//                             }
//                         });
//                     }else{
//                         model.cardId=cardDB.cardId;
//                     }
//                     await stripeService.generatePaymentIntent({
//                         "receipt_email": userDB.email,
//                         "amount": params.amount,
//                         "card_id": model.cardId,
//                         "customer_id": model.stripeCustomerID,
//                     },(error, results)=>{
//                         if(error){
//                             return callback(error);
//                         }if(results){
//                             model.paymentIntentId=results.id;
//                             model.client_secret=results.client_secret;
//                         }
//                     });
//                     cartService.getCart({
//                         userId:userDB._id,
//                     },function(err, cartDB){
//                         if(err){
//                             return callback(err);
//                         }else{
//                             if(cartDB){
//                                 var products=[];
//                                 var grandTotal=0;
//                                 cartDB.products.forEach(products => {
//                                     products.push({
//                                         product:products.product._id,
//                                         qty:products.qty,
//                                         amount:products.product.productSalePrice,
//                                     });
//                                     grandTotal+=products.product.productSalePrice*products.qty;
//                                 });

//                                 const orderModel=new order({
//                                     userId:cartDB.userId,
//                                     products:products,
//                                     orderStatus:'Pending',
//                                     grandTotal:grandTotal,
//                                 });
//                                 orderModel.save()
//                                 .then((response)=>{
//                                     model.orderId=response._id;
//                                     return callback(null, model);
//                                 }).catch((error)=>{
//                                     return callback(error);
//                                 })
//                             }
//                         }
//                     });
//                 }
//             });
//         }
//     });
// }

async function updateOrder(params, callback) {
    var model = {
        orderStatus: params.status,
        transactionId: params.transaction_id
    };
    order.findByIdAndUpdate(params.orderId, model, { new: true },)
        .then((response) => {
            if (!response) {
                return callback('Order Update failed');
            } else {
                if (params.status == "success") {

                }
                return callback(null, response);
            }
        }).catch((error) => {
            return callback(error);
        });
}

async function getOrder(params, callback) {
    order.findOne({
        userId: params.userId,
    }).populate({
        path: "products",
        populate: {
            path: 'product',
            model: 'Product',
            populate: {
                path: 'category',
                model: 'Category',
                select: 'CategoryName'
            }
        }
    }).then((response) => {
        return callback(null, response);
    }).catch((error) => {
        return callback(error);
    });
}

module.exports = {
    createOrder,
    updateOrder,
    getOrder
};