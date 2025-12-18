const {STRIPE_CONFIG} = require("../config/app.config");
const stripe = require("stripe")(STRIPE_CONFIG.STRIPE_KEY);


async function createCustomer(params) {
    try {
        const customer = await stripe.customers.create({
            name: params.name,
            email: params.email,
        });
        return customer; // Return the customer directly
    } catch (error) {
        throw error; // Throw the error to be handled by the caller
    }
}

async function addCard(params) {
    try {
        console.log("🧪 addCard() params:", params);
        console.log("adding to card got clicked");
        const card_token = await stripe.tokens.create({
            card:{
            name: params.card_Name,
            number: params.card_Number,
            exp_month: params.card_ExpMonth,
            exp_year: params.card_ExpYear,
            cvc: params.card_CVC,
    }});

        const card = await stripe.customers.createSource(params.customer_Id, {
            source: `${card_token.id}`,
        });

        return { card: card.id }; // Return the card ID directly
    } catch (error) {
        throw error; // Throw the error to be handled by the caller
    }
}

async function generatePaymentIntent(params) {
    try {
        const createPaymentIntent = await stripe.paymentIntents.create({
            receipt_email: params.receipt_email,
            amount: params.amount*100,
            currency: STRIPE_CONFIG.CURRENCY,
            payment_method: params.card_id,
            customer: params.customer_id,
            payment_method_types: ['card'],
        });

        return createPaymentIntent; // Return the payment intent directly
    } catch (error) {
        throw error; // Throw the error to be handled by the caller
    }
}

module.exports = {
    createCustomer,
    addCard,
    generatePaymentIntent,
};

// async function createCustomer(params, callback){
//     try{
//         const customer =await stripe.customers.create({
//             name:params.name,
//             email:params.email,
//     });
//         return callback(null, customer);
//     }catch(error){
//         return callback(error);
//     }
// }

// async function addCard(params, callback){
//     try{
//         const card_token=await stripe.tokens.create({
//             name:params.card_Name,
//             number:params.card_Number,
//             exp_month:params.card_ExpMonth,
//             exp_year:params.card_ExpYear,
//             cvc:params.card_CVC,
//         });
//         const card=await stripe.customers.createSource(params.customer_Id, {
//             source: `${card_token.id}`,
//         });
//         callback(null, {card:card.id});
//     }catch(error){
//         return callback(error);
//     }
// }

// async function generatePaymentIntent(params, callback){
//     try{
//         const createPaymentIntent = await stripe.paymentIntents.create({
//             receipt_email: params.receipt_email,
//             amount: params.amount,
//             currency: STRIPE_CONFIG.CURRENCY,
//             payment_method: params.card_id,
//             customer: params.customer_id,
//             payment_method_types: ['card'],
//         });
//         return callback(null, paymentIntent);
//     }catch(error){
//         return callback(error);
//     }
// }

// module.exports={
//     createCustomer,
//     addCard,
//     generatePaymentIntent,
// };