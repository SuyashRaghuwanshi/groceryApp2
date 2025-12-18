const orderService = require('../services/order.service');

exports.create = async (req, res, next) => {
    console.log("➡️ ORDER ROUTE HIT");
    console.log("req.user:", req.user);
    console.log("req.body:", req.body);

    try {
        const model = {
            userId: req.user.userId,
            amount: req.body.amount,

            card_Name: req.body.card_Name,
            card_Number: req.body.card_Number,
            card_ExpMonth: req.body.card_ExpMonth,
            card_ExpYear: req.body.card_ExpYear,
            card_CVC: req.body.card_CVC,
        };


        const results = await orderService.createOrder(model);

        return res.status(200).send({
            message: "Success",
            data: results,
        });
    } catch (error) {
        console.log("❌ ORDER ERROR:", error);
        return next(error);
    }
};


exports.update = (req, res, next) => {
    orderService.updateOrder(req.body, (error, results) => {
        if (error) {
            return next(error);
        }
        return res.status(200).send({
            message: "Success",
            data: results,
        });
    })
}

exports.findAll = (req, res, next) => {
    orderService.getOrder(req.body, (error, results) => {
        if (error) {
            return next(error);
        }
        return res.status(200).send({
            message: "Success",
            data: results,
        });
    })
}