import KeyValueStorage from './KeyValueStorage';
import { DynamoDB } from 'aws-sdk';
import safeLoggerWrapper from './safeLoggerWrapper';


class DynamoDBService<T> implements KeyValueStorage<T> {
    private dynamoDB: DynamoDB;
    private tableName: string;
    private keyName: string;
    private keyType: string;
    private region: string;

    get TableName(): string {
        return this.tableName;
    }

    get Region(): string {
        return this.region;
    }

    private logInformation: (infoMsg: string) => any = function (inforMsg: string) {
        console.log(inforMsg);
    }

    private logError: (errorMsg: string) => any = function (errorMsg: string) {
        this.logInformation(errorMsg);
    }

    constructor(tableName: string, keyName: string, region: string, keyType: string = "S",
        logInformation: (infoMsg: string) => any = null,
        logError: (errorMsg: string) => any = null) {

        this.tableName = tableName;
        this.keyName = keyName;
        this.keyType = keyType;

        if (logInformation) {
            this.logInformation = safeLoggerWrapper(logInformation);
        }

        if (logError) {
            this.logError = safeLoggerWrapper(logError);
        }

        this.region = region;
        const config = {
            "apiVersions": {
                dynamodb: '2012-08-10'
            },
            "region": region
        };
        this.dynamoDB = new DynamoDB(config);
    }

    public async put(key: string, valueObj: T) {
        const baseInfo = this.getBaseInfo(key, valueObj);
        const thisObj = this;
        await new Promise<void>((resolve, reject) => {
            this.dynamoDB.putItem(baseInfo, (err, putItemOutput) => {
                if (err) {
                    thisObj.logError(`dynamodb put action is done with error, key: ${key}, DynamoDBRequestId: ${err.requestId}`);
                    reject(err);
                }
                thisObj.logInformation("dynamodb put is done");
                resolve();
            });
        });
    }

    public async get(key: string): Promise<T> {
        const queryInfo = this.getBaseInfo(key, null);
        const thisObj = this;
        return await new Promise<T>((resolve, reject) => {
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
    }

    private getBaseInfo(key: string, valueObj: T): any {
        let valueObjSnippet = "";
        if (valueObj) {
            valueObjSnippet = `,
            "valueObj": {
                "S": ${JSON.stringify(JSON.stringify(valueObj))}
            }`
        };

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

export default DynamoDBService;