"use strict";

function getRandomInt(max, min) {
    const gap = min ? max - min : max;
    const randomInt = Math.floor(Math.random() * Math.floor(gap));
    return min ? randomInt + min : randomInt;
}

console.log("----------getRandomInt is loaded----------")

module.exports = getRandomInt;