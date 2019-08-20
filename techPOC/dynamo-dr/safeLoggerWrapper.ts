function safeLoggerWarpper(logFunction: (message: string) => any){
    return (message:string) => {
        try{
            logFunction(message);
        }
        catch(ex){
            console.log("Failed to write log");
            console.log(ex);
        }
    }
}

export default safeLoggerWarpper;