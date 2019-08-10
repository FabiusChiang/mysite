import Hello from "./hello"
// import UserStatusManager from "./userStatusManager";
import DynamoDBService from "./dynamoDBService";
import UserStatus from "./userStatus";

class Index {
    static async main() {
        console.log("Main function is called");
        const helloObj = new Hello();
        await helloObj.greetings();
        await helloObj.greetingToRemote();

        await this.dynamoDBSpike();

        console.log("Main function ends");
    }

    static async dynamoDBSpike() {
        try {
            // const usManager : UserStatusManager = new UserStatusManager();
            // await usManager.Put();

            const userInfo0: UserStatus = {
                id: "FE48822D-BF50-44A1-9CE0-61B06504D726",
                status: "3no_aggregation"
            };
            const userInfo1: UserStatus = {
                id: "EE48822D-BF50-44A1-9CE0-61B06504D726",
                status: "4no_aggregation"
            };

            const dbService: DynamoDBService<UserStatus> = 
                new DynamoDBService<UserStatus>("fabiusT-user-info-east-2", "userId", "us-east-1");
            // await dbService.Put(userInfo1.id, userInfo1);
            const userInfo: UserStatus = await dbService.get(userInfo0.id);
            console.log(userInfo);
        }
        catch (ex) {
            console.log(ex);
        }
    }
}

Index.main();