class Hello {
    async greetings() {
        console.log("greetings is sent.");
    }

    async greetingToRemote() {
        console.log(this.addTimestamp("Sending a message slowly"));
        const thisObj = this;
        await new Promise<void>(function(resolve, reject) {
            setTimeout(() => {
                console.log(thisObj.addTimestamp("Sending slow message is done"));
                resolve();
            }, 1000*2);
          });
    }

    private addTimestamp(text: string) : string {
        return this.getTime() + ": " + text;
    }

    private getTime(): string {
        const d = new Date();
        return d.toISOString();
    }
}

export default Hello;