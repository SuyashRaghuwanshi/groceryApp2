const mongoose = require('mongoose');
const { Schema } = mongoose;

const user=mongoose.model(
    "User",
    mongoose.Schema({
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
    },{
        toJSON: {
            transform: function (doc, ret) {
                ret.userId = ret._id.toString();
                delete ret._id;
                delete ret.__v;
                delete ret.password;
            },
        },
    },{
        timestamps: true, // Fixed spelling
    }
)
);
module.exports={
    user
}