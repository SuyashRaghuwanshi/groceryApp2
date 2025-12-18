const { user } = require('../models/user.model'); // Fixed import
const bcrypt = require('bcrypt');
const auth = require('../middleware/auth');
const { response } = require('express');

async function login({ email, password }, callback) {
    try {
        const userModel = await user.findOne({ email });
        console.log("User found:", userModel);
        if (userModel != null) {
            console.log("Before token gen:", userModel);
            console.log("After toJSON:", userModel.toJSON());
            console.log("Has _id?", userModel._id);
            console.log("JSON _id:", userModel.toJSON()._id);


            if (bcrypt.compareSync(password, userModel.password)) {
                const token = auth.generateAccessToken(userModel.toJSON());
                return callback(null, { ...userModel.toJSON(), token });
            } else {
                return callback({ message: 'Invalid Email/Password' });
            }
        } else {
            return callback({ message: 'Invalid Email/Password' });
        }
    } catch (error) {
        return callback(error);
    }
}

async function register(params, callback) {
    try {
        console.log("🔍 Register Params:", params);
        if (params.email === undefined) {
            console.log("❌ Missing Fields!");
            return callback({ message: "Email Required!" });
        }
        let isUserExist = await user.findOne({ email: params.email });
        if (isUserExist) {
            console.log("❌ Email already exists!");
            return callback({ message: "Email already exists" });
        }
        const salt = bcrypt.genSaltSync(10);
        params.password = bcrypt.hashSync(params.password, salt);
        const userSchema = new user(params);
        userSchema.save()
            .then((response) => {
                console.log("✅ User Registered:", response);
                return callback(null, response);
            })
            .catch((error) => {
                console.error("❌ Register Error:", error);
                return callback(null, response);
            });
    } catch (error) {
        console.error("❌ Register Error:", error);
        return callback(error);
    }
}



module.exports = { login, register };