"use strict";

module.exports = {
    getStartTime () {
        return process.hrtime();
    },
    
    getElaspedSecondes (startTime) {
        const nanoSecToSec = 1e9;
        const elaspedTime = process.hrtime(startTime);
        const seconds = elaspedTime[0] + elaspedTime[1] / nanoSecToSec;
        return seconds;
    }
}