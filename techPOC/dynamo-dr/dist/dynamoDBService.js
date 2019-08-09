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
class DynamoDBService {
    constructor() {
        this.tableName = "fabiusT-user-info-east-2";
        this.keyName = "userId";
        this.keyType = "S";
        const config = {
            "apiVersions": {
                dynamodb: '2012-08-10'
            },
            "region": "us-east-1"
        };
        this.dynamoDB = new aws_sdk_1.DynamoDB(config);
    }
    getBaseInfo(key, valueObj) {
        let valueObjSnippet = "";
        if (valueObj) {
            valueObjSnippet = `,
            "valueObj": {
                "S": ${JSON.stringify(JSON.stringify(valueObj))}
            }`;
        }
        ;
        const keyInfoJsonString = `{
            "${valueObj ? "Item" : "Key"}": {  
                    "${this.keyName}": {
                        "${this.keyType}": "${key}"
                    }${valueObjSnippet}                    
                },
            "ReturnConsumedCapacity": "TOTAL",
            "TableName": "${this.tableName}"
        }`;
        return JSON.parse(keyInfoJsonString);
    }
    Put(key, valueObj) {
        return __awaiter(this, void 0, void 0, function* () {
            const baseInfo = this.getBaseInfo(key, valueObj);
            console.log(baseInfo);
            yield new Promise((resolve, reject) => {
                this.dynamoDB.putItem(baseInfo, (err, putItemOutput) => {
                    if (err) {
                        reject(err);
                    }
                    console.log("dynamodb put is done");
                    resolve();
                });
            });
        });
    }
    Get(key) {
        return __awaiter(this, void 0, void 0, function* () {
            const queryInfo = this.getBaseInfo(key, null);
            return yield new Promise((resolve, reject) => {
                this.dynamoDB.getItem(queryInfo, (err, data) => {
                    if (err) {
                        reject(err);
                    }
                    const jsonObj = JSON.parse(JSON.stringify(data.Item)).valueObj.S;
                    console.log("dynamodb get is done");
                    resolve(jsonObj);
                });
            });
        });
    }
}
exports.default = DynamoDBService;
//# sourceMappingURL=dynamoDBService.js.map