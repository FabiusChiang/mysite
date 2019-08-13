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
    constructor(tableName, keyName, region, keyType = "S") {
        this.tableName = tableName;
        this.keyName = keyName;
        this.keyType = keyType;
        const config = {
            "apiVersions": {
                dynamodb: '2012-08-10'
            },
            "region": region
        };
        this.dynamoDB = new aws_sdk_1.DynamoDB(config);
    }
    put(key, valueObj) {
        return __awaiter(this, void 0, void 0, function* () {
            const baseInfo = this.getBaseInfo(key, valueObj);
            yield new Promise((resolve, reject) => {
                this.dynamoDB.putItem(baseInfo, (err, putItemOutput) => {
                    if (err) {
                        console.log(`dynamodb put action is done with error, key: ${key}, DynamoDBRequestId: ${err.requestId}`);
                        reject(err);
                    }
                    console.log("dynamodb put is done");
                    resolve();
                });
            });
        });
    }
    get(key) {
        return __awaiter(this, void 0, void 0, function* () {
            const queryInfo = this.getBaseInfo(key, null);
            return yield new Promise((resolve, reject) => {
                this.dynamoDB.getItem(queryInfo, (err, data) => {
                    if (err) {
                        console.log(`dynamodb get action is done with error, key: ${key}, DynamoDBRequestId: ${err.requestId}`);
                        reject(err);
                    }
                    const jsonObj = JSON.parse(data.Item.valueObj.S);
                    console.log("dynamodb get is done");
                    resolve(jsonObj);
                });
            });
        });
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
}
exports.default = DynamoDBService;
//# sourceMappingURL=dynamoDBService.js.map