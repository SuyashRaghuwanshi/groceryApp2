const mongoose = require('mongoose');
const { Schema } = mongoose;

const user = mongoose.model(
    "User",
    new mongoose.Schema(
        {
            fullName: {
                type: String,
                required: true,
            },
            email: {
                type: String,
                required: true,
                unique: true,
            },
            password: {
                type: String,
                required: true,
            },
            stripeCustomerId: {
                type: String,
            },
        },
        {
            timestamps: true, 

            toJSON: {
                transform: function (doc, ret) {
                    ret.userId = ret._id.toString();

                    // FIX: DO NOT DELETE _id → your JWT needs it
                    // delete ret._id;

                    delete ret.__v;
                    delete ret.password;
                },
            },
        }
    )
);

module.exports = {
    user
};
