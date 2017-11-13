console.log("--------------loading polite hello.js");
const delimeter = ':';

const hello = require("./hello");
const hoody = require("./hoody");

module.exports = class extends hello {
    constructor(name) {
        super(name);
        // this.myName = name;
        // console.log(`constructor${delimeter}${name}`);
    }

    // actionA() {
    //     super.actionA();
    //     console.log("in polite manner!");
    // }

    actionB() {
        console.log("hey actionB!");
        // hoody.actionC();
        const obj3 = new hoody();
        obj3.actionC();
    }
}
