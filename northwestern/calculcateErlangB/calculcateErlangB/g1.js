"use strict";

const calc = require("./funcs");

const bht = calc.ErlangBBHT(0.02, 60);
const lines = calc.ErlangBLines(49.6, 0.02);
const blockProbability = calc.ErlangB(49.6, 60);


console.log(bht);
console.log(lines);
console.log(blockProbability);