"use strict";

const calc = require("./funcs");
const fs = require("fs");

const bht = 0.000624 * 10000;

console.log(calc.ErlangB(bht, 10));

console.log(calc.ErlangBLines(bht, 0.01));
