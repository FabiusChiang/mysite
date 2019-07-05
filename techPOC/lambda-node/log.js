"use strict";

function log (guid, logContent) {
    const time = new Date();
    const fullLog = `${guid} ${time.toISOString()} ${logContent}`
    console.log(fullLog);
}

module.exports = log;