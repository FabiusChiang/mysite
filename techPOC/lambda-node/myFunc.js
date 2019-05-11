"use strict";

const uuid = require('uuid/v4')
const log = require('./log')

function hold(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function getRandomInt(max, min) {
    const gap = min ? max - min : max;
    const randomInt = Math.floor(Math.random() * Math.floor(gap));
    return min ? randomInt + min : randomInt;
}

async function myFunc (event, context, callback) {
    const uidOfEvent = uuid();
    for(var i=0; i<10; i++){
        const holdmilliSec = getRandomInt(1100, 100);
        await hold(holdmilliSec);
        log(uidOfEvent, `Progress is ${i}`);
    }
}

module.exports = myFunc;