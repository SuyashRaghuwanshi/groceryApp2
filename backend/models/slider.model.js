const mongoose = require("mongoose");

const slider = mongoose.model(
    "Sliders",
    mongoose.Schema({
        sliderName: {
            type: String,
            required: true,
            unique: true,
        },
        sliderDescription: {
            type: String,
            required: false,
        },
        sliderURL: {
            type: String,
            required: false,
        },
        sliderImage: {
            type: String,
            required: false,
        },
    }
));

module.exports={
    slider
}