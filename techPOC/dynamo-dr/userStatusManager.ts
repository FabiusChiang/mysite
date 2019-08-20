import MultiRegionDynamoDBService from "./MultiRegionDynamoDBService";
import KeyValueStorage from "./KeyValueStorage";
import UserStatus from "./UserStatus";

class UserStatusManager {
    private dbService: KeyValueStorage<UserStatus>;

    constructor() {
        const config = {
            keyName: "userId",
            keyType: "S",
            regionConfigs: [
                {
                    tableName: "fabiusT-user-info-east-2",
                    region: "us-east-1",
                    primary: true
                },
                {
                    tableName: "fabiusT-user-info-west-2",
                    region: "us-west-2"
                }
            ]
        };
        this.dbService = new MultiRegionDynamoDBService(config);
    }
    public async storeUserStatus(userStatus: UserStatus): Promise<void> {
        await this.dbService.put(userStatus.id, userStatus);
    }

    public async getUserStatus(userId: string): Promise<UserStatus> {
        return await this.dbService.get(userId);
    }
}

export default UserStatusManager;