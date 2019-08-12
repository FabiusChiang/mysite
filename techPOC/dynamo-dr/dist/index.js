"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const dynamoDBService_1 = require("./dynamoDBService");
const userStatusManager_1 = require("./userStatusManager");
const multiRegionDynamoDBService_1 = require("./multiRegionDynamoDBService");
class Index {
    static main() {
        return __awaiter(this, void 0, void 0, function* () {
            console.log("Main function is called");
            yield this.demoUserStatusManager();
            console.log("Main function ends");
        });
    }
    static demoUserStatusManager() {
        return __awaiter(this, void 0, void 0, function* () {
            const userStatusManager = new userStatusManager_1.default();
            const sampleUserStatus = {
                id: "AA48822D-BF50-44A1-9CE0-61B06504D726",
                status: "#1 - This is the status of sample user"
            };
            yield userStatusManager.storeUserStatus(sampleUserStatus);
            const userInfoFromDB = yield userStatusManager.getUserStatus(sampleUserStatus.id);
            console.log(userInfoFromDB.status);
        });
    }
    static multiDynamoDBSpike() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const userInfo0 = {
                    id: "FE48822D-BF50-44A1-9CE0-61B06504D726",
                    status: "33no_aggregation"
                };
                const userInfo1 = {
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
                const dbService = new multiRegionDynamoDBService_1.default(config);
                yield dbService.put(userInfo1.id, userInfo1);
                const userInfo = yield dbService.get(userInfo0.id);
                console.log(userInfo);
            }
            catch (ex) {
                console.log(ex);
            }
        });
    }
    static dynamoDBSpike() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const userInfo0 = {
                    id: "FE48822D-BF50-44A1-9CE0-61B06504D726",
                    status: "3no_aggregation"
                };
                const userInfo1 = {
                    id: "EE48822D-BF50-44A1-9CE0-61B06504D726",
                    status: "4no_aggregation"
                };
                const dbService = new dynamoDBService_1.default("fabiusT-user-info-east-2", "userId", "us-east-1");
                const userInfo = yield dbService.get(userInfo0.id);
                console.log(userInfo);
            }
            catch (ex) {
                console.log(ex);
            }
        });
    }
}
Index.main();
//# sourceMappingURL=index.js.map