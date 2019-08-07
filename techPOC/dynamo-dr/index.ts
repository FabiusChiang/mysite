import Hello from "./hello"

class Index {
    static async main() {
        console.log("Main function is called");
        const helloObj = new Hello();
        await helloObj.greetings();
        await helloObj.greetingToRemote();
        console.log("Main function ends");
    }
}


Index.main();