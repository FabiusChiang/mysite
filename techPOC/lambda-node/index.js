'use strict'

// import myFuc from "./myFunc";
const myFunc = require("./myFunc")

exports.myHandler = async function(event, context) {   
    myFunc();
    // callback(null, "no news");
}

