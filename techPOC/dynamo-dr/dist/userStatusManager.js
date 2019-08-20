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
const MultiRegionDynamoDBService_1 = require("./MultiRegionDynamoDBService");
class UserStatusManager {
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
        this.dbService = new MultiRegionDynamoDBService_1.default(config);
    }
    storeUserStatus(userStatus) {
        return __awaiter(this, void 0, void 0, function* () {
            yield this.dbService.put(userStatus.id, userStatus);
        });
    }
    getUserStatus(userId) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.dbService.get(userId);
        });
    }
}
exports.default = UserStatusManager;
//# sourceMappingURL=UserStatusManager.js.map