"use strict";

const calc = require("./funcs");

const bht = 100000 * 1 / 10 * 0.001;

console.log(calc.ErlangBBHT(0.01, 122) / 0.25);

console.log(calc.ErlangBBHT(0.01, 282) / 0.25);

console.log(calc.ErlangBBHT(0.01, 625) / 0.25);


//console.log(calc.ErlangBLines(bht, 0.01));
