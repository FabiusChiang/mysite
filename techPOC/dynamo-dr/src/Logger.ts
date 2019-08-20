class Logger {
    async greetings() {
        console.log("greetings is sent.");
    }

    async greetingToRemote() {
        console.log(this.addTimestamp("Sending a message slowly"));
        await new Promise<void>(function(resolve, reject) {
            setTimeout(() => {
                console.log(this.addTimestamp("Sending slow message is done"));
                resolve();
            }, 1000*2);
          });
    }

    public getLogInfoFunc(){
        return this.LogInfo.bind(this);
    }

    public LogInfo(text: string){
        console.log(this.addTimestamp(text));
    }

    public LogWarning(text: string){
        console.warn(this.addTimestamp(text));
    }

    public LogError(text: string){
        console.error(this.addTimestamp(text));
    }

    private addTimestamp(text: string) : string {
        return this.getTime() + ": " + text;
    }

    private getTime(): string {
        const d = new Date();
        return d.toISOString();
    }


    // public static LogInfo(text: string){
    //     console.log(this.addTimestamp(text));
    // }

    // public static LogWarning(text: string){
    //     console.warn(this.addTimestamp(text));
    // }

    // public static LogError(text: string){
    //     console.error(this.addTimestamp(text));
    // }

    // private static addTimestamp(text: string) : string {
    //     return this.getTime() + ": " + text;
    // }

    // private static getTime(): string {
    //     const d = new Date();
    //     return d.toISOString();
    // }
}

export default Logger;