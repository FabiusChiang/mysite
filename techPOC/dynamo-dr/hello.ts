class Hello {
    async greetings() {
        console.log("greetings is sent.");
    }

    greetingToRemote(): Promise<void> {
        console.log(this.addTimestamp("Sending a message slowly"));
        return new Promise(function(resolve, reject) {
            setTimeout((() => {
                console.log(this.addTimestamp("Sending slow message is done"));
                resolve();
            }).bind(this), 1000*2);
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