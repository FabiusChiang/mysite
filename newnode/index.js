'use strict'

var request = require('request')

// var request = Promise.promisifyAll(require("request"))
const requestOptions = {
    // uri: "http://www.163.com",
    uri: "https://www.google.com"
    // ,proxy: "http://localhost:8080"
    // proxy: "http://192.168.31.13:10086"
}



request.get(requestOptions.uri, requestOptions, function (error, rep) {
        console.log(rep.body);
        if (rep.body){
            console.log("body exists");
        }
        if (!rep.body2){
            console.log("body2 not exists");
        }
        rep.body2 = "1bc";
        if (rep.body2){
            console.log(rep.body2);
        }
    });

