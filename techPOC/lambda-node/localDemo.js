'use strict'

// import myFuc from "./myFunc";
const index = require("./index")

async function main(){
    const result = await index.myHandler();
    console.log(result);
}

main();
