"use strict";

const calc = require("./funcs");
const fs = require("fs");

function fillData(dataArray) {
    dataArray.forEach(item => {
        if (!item.bht) {
            item.bht = calc.ErlangBBHT(item.pb, item.line);
        }
        else if (!item.pb) {
            item.pb = calc.ErlangB(item.pb, item.line);
        }
        else if (!item.line) {
            item.line = calc.ErlangBLines(item.pb, item.line);
        }
    });
}

async function outputData(dataArray, fileName) {
    let stringValue = "Pb,Circuit,n*R\r\n";
    dataArray.forEach(item => {
        stringValue = stringValue + `${item.pb},${item.line},${item.bht}` + "\r\n";
    });
    await fs.writeFile(fileName, stringValue, error => {
        console.log(error);
    });
}

const sourceData1a = [];

let pb = 0.01;
for (let i = 0; i < 10; i++) {
    sourceData1a.push({
        pb: pb + pb * i,
        line: 24
    });
}

fillData(sourceData1a);
Promise.resolve(outputData(sourceData1a, "g1a.csv"));

const sourceData1b = [];

for (let i = 0; i < 10; i++) {
    sourceData1b.push({
        pb: pb + pb * i,
        line: 774
    });
}

fillData(sourceData1b);
Promise.resolve(outputData(sourceData1b, "g1b.csv"));