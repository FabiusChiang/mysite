console.log("-------------loading hello.js");
const delimeter = ':';

module.exports = class Hello {
    constructor(name) {
        this.myName = name;
        console.log(`constructor${delimeter}${name}`);
    }

    actionA() {
        console.log(`actionA${delimeter}${this.myName}`);
    }
}
