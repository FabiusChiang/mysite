import Hello from "./hello"
import DynamoDBService from "./DynamoDBService";
import UserStatusManager from "./userStatusManager";
import UserStatus from "./userStatus";
import KeyValueStorage from "./KeyValueStorage";
import MultiRegionDynamoDBService from "./multiRegionDynamoDBService";


class Index {
    static async main() {
        console.log("Main function is called");
        // const helloObj = new Hello();
        // await helloObj.greetings();
        // await helloObj.greetingToRemote();

        // await this.dynamoDBSpike();

        //await this.multiDynamoDBSpike();

        await this.demoUserStatusManager();

        console.log("Main function ends");
    }


    static async demoUserStatusManager() {
        const userStatusManager = new UserStatusManager();

        const sampleUserStatus: UserStatus = {
            id: "AA48822D-BF50-44A1-9CE0-61B06504D726",
            status: "#1 - This is the status of sample user"
        };

        await userStatusManager.storeUserStatus(sampleUserStatus);
        const userInfoFromDB = await userStatusManager.getUserStatus(sampleUserStatus.id)
        console.log(userInfoFromDB.status);

    }

    static async multiDynamoDBSpike() {
        try {
            // const usManager : UserStatusManager = new UserStatusManager();
            // await usManager.Put();

            const userInfo0: UserStatus = {
                id: "FE48822D-BF50-44A1-9CE0-61B06504D726",
                status: "33no_aggregation"
            };
            const userInfo1: UserStatus = {
                id: "EE48822D-BF50-44A1-9CE0-61B06504D726",
                status: "44no_aggregation"
            };

            const config = {
                keyName: "userId",
                keyType: "S",
                regionConfigs: [
                    {
                        tableName: "fabiusT-user-info-east-2",
                        region: "us-east-1"
                    },
                    {
                        tableName: "fabiusT-user-info-west-2",
                        region: "us-west-2"
                    }
                ]
            };

            const dbService: KeyValueStorage<UserStatus> = 
                new MultiRegionDynamoDBService<UserStatus>(config);
            await dbService.put(userInfo1.id, userInfo1);
            const userInfo: UserStatus = await dbService.get(userInfo0.id);
            console.log(userInfo);
        }
        catch (ex) {
            console.log(ex);
        }
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