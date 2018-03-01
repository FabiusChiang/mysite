"use strict";

const calc = require("./funcs");
const fs = require("fs");

const x = 1 / 12;
console.log(`x is ${x}`);

console.log(calc.ErlangBBHT(0.01, 24));
console.log(calc.ErlangBBHT(0.01, 24) / x);

console.log(calc.ErlangBBHT(0.01, 48));
console.log(calc.ErlangBBHT(0.01, 48) / x);

console.log(calc.ErlangBBHT(0.01, 96));
console.log(calc.ErlangBBHT(0.01, 96) / x);

console.log(calc.ErlangBLines(6000 * x, 0.01));