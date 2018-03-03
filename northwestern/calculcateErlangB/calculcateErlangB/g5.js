"use strict";

const calc = require("./funcs");
const fs = require("fs");

const bht = 100000 * 1 / 10 * 0.001;

console.log(calc.ErlangBBHT(0.01, 47) / 0.3 * 10);

console.log(calc.ErlangBBHT(0.01, 34) / 0.3 * 20);

console.log(calc.ErlangBBHT(0.01, 22) / 0.3 * 40);
