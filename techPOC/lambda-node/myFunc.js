"use strict";

const uuid = require('uuid/v4')
const log = require('./log')

function hold(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

async function myFunc (event, context, callback) {
    const uidOfEvent = uuid();
    for(var i=0; i<10; i++){
        const getRandomInt = require('./getRandomInt');  //put the require in for on purpose, though it will NOT be loaded for more than once in the same process.
        const holdmilliSec = getRandomInt(1100, 100);
        await hold(holdmilliSec);
        log(uidOfEvent, `Progress is ${i}`);
    }
    return "It's done";
}

module.exports = myFunc;