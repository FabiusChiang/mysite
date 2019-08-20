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
const safeLoggerWrapper_1 = require("./safeLoggerWrapper");
class DynamoDBService {
    constructor(tableName, keyName, region, keyType = "S", logInformation = null, logError = null) {
        this.logInformation = function (inforMsg) {
            console.log(inforMsg);
        };
        this.logError = function (errorMsg) {
            this.logInformation(errorMsg);
        };
        this.tableName = tableName;
        this.keyName = keyName;
        this.keyType = keyType;
        if (logInformation) {
            this.logInformation = safeLoggerWrapper_1.default(logInformation);
        }
        if (logError) {
            this.logError = safeLoggerWrapper_1.default(logError);
        }
        this.region = region;
        const config = {
            "apiVersions": {
                dynamodb: '2012-08-10'
            },
            "region": region
        };
        this.dynamoDB = new aws_sdk_1.DynamoDB(config);
    }
    get TableName() {
        return this.tableName;
    }
    get Region() {
        return this.region;
    }
    put(key, valueObj) {
        return __awaiter(this, void 0, void 0, function* () {
            const baseInfo = this.getBaseInfo(key, valueObj);
            const thisObj = this;
            yield new Promise((resolve, reject) => {
                this.dynamoDB.putItem(baseInfo, (err, putItemOutput) => {
                    if (err) {
                        thisObj.logError(`dynamodb put action is done with error, key: ${key}, DynamoDBRequestId: ${err.requestId}`);
                        reject(err);
                    }
                    thisObj.logInformation("dynamodb put is done");
                    resolve();
                });
            });
        });
    }
    get(key) {
        return __awaiter(this, void 0, void 0, function* () {
            const queryInfo = this.getBaseInfo(key, null);
            const thisObj = this;
            return yield new Promise((resolve, reject) => {
                this.dynamoDB.getItem(queryInfo, (err, data) => {
                    if (err) {
                        thisObj.logError(`dynamodb get action is done with error, key: ${key}, DynamoDBRequestId: ${err.requestId}`);
                        reject(err);
                    }
                    const jsonObj = JSON.parse(data.Item.valueObj.S);
                    thisObj.logInformation("dynamodb get is done");
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
//# sourceMappingURL=DynamoDBService.js.map