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
const aws_sdk_1 = require("aws-sdk");
class UserStatusManager {
    constructor() {
        const config = {
            "apiVersions": {
                dynamodb: '2012-08-10'
            },
            "region": "us-east-1"
        };
        this.dynamoDB = new aws_sdk_1.DynamoDB(config);
    }
    Put() {
        return __awaiter(this, void 0, void 0, function* () {
            var params = {
                Item: {
                    "id": {
                        N: "2"
                    },
                    "content": {
                        S: "This is test content of 2"
                    },
                    "content2": {
                        M: {
                            "Name": { S: "Joe" },
                            "Age": { N: "29" }
                        }
                    }
                },
                ReturnConsumedCapacity: "TOTAL",
                TableName: "fabiusTestEast"
            };
            yield new Promise((resolve, reject) => {
                this.dynamoDB.putItem(params, (err, putItemOutput) => {
                    console.log(err);
                    console.log(putItemOutput);
                    console.log("dynamodb call is done");
                    resolve();
                });
            });
        });
    }
    Get() {
        return __awaiter(this, void 0, void 0, function* () {
        });
    }
}
exports.default = UserStatusManager;
//# sourceMappingURL=userStatusManager.js.map