'use strict'

// import myFuc from "./myFunc";
const myFunc = require("./myFunc")

exports.myHandler = async function(event, context) {   
    const result = await myFunc();
    // callback(null, "no news");

    return {
        statusCode: 200, 
        headers: {
            "x-custom-header" : "forFun"}, 
            body: JSON.stringify(result) 
        };
}

