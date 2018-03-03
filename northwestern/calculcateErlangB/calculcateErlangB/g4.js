"use strict";

const calc = require("./funcs");
const fs = require("fs");

const bht = 100000 * 1 / 10 * 0.001;

console.log(calc.ErlangBLines(bht, 0.02));

console.log(calc.ErlangBLines(2 * bht, 0.02));

//console.log(calc.ErlangBLines(bht, 0.01));
