const orderService=require('../services/order.service');

// exports.create=(req,res,next)=>{
//     var model={
//         userId:req.user.userId,
//         card_Name:req.body.card_Name,
//         card_Number:req.body.card_Number,
//         card_ExpMonth:req.body.card_ExpMonth,
//         card_ExpYear:req.body.card_ExpYear,
//         card_CVC:req.body.card_CVC,
//         amount:req.body.amount,
//     }
//     orderService.createOrder(model,(error,results)=>{
//         if(error){
//             return next(error);
//         }
//         return res.status(200).send({
//             message:"Success",
//             data:results,
//         });
//     });
// }

exports.create = async (req, res, next) => {
    try {
        const model = {
            userId: req.user.userId,
            card_Name: req.body.card_Name,
            card_Number: req.body.card_Number,
            card_ExpMonth: req.body.card_ExpMonth,
            card_ExpYear: req.body.card_ExpYear,
            card_CVC: req.body.card_CVC,
            amount: req.body.amount,
        };

        // Await the result directly from createOrder (no callback needed)
        const results = await orderService.createOrder(model);

        return res.status(200).send({
            message: "Success",
            data: results, // Send the model data as the response
        });
    } catch (error) {
        return next(error); // Forward the error to the next middleware (error handler)
    }
};

exports.update=(req, res, next)=>{
    orderService.updateOrder(req.body, (error, results)=>{
        if(error){
            return next(error);
        }
        return res.status(200).send({
            message:"Success",
            data:results,
        });
    })
}

exports.findAll=(req, res, next)=>{
    orderService.getOrder(req.body, (error, results)=>{
        if(error){
            return next(error);
        }
        return res.status(200).send({
            message:"Success",
            data:results,
        });
    })
}