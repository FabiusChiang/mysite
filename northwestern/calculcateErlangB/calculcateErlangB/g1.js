"use strict";

const calc = require("./funcs");

const sourceData = [];

let pb = 0.01;
for (let i = 0; i < 10; i++) {
    sourceData.push({
        pb: pb + pb * i,
        line: 24
    });
}

function fillData(dataArray) {
    dataArray.forEach(item => {
        if (!item.bht) {
            item.bht = calc.ErlangBBHT(item.pb, item.line);
        }
        else if (!item.pb) {
            item.pb = calc.ErlangBBHT(item.pb, item.line);
        }
        else if (!item.line) {
            item.line = calc.ErlangBBHT(item.pb, item.line);
        }
    });
}


function getUsersInBatch(dataArray) {
    dataArray.forEach(item => {
        item.bht = calc.ErlangBBHT(item.pb, 60);
        item.users = item.bht / 0.1;
        console.log(item);
    });
}

getUsersInBatch(sourceData);

//console.log(bht);
//console.log(lines);
//console.log(blockProbability);