import IKeyValueStorage from "./IKeyValueStorage";
import { config, DynamoDB } from 'aws-sdk';
import { resolve } from 'path';


class DynamoDBService<T> implements IKeyValueStorage<T> {
    private dynamoDB: DynamoDB;
    private tableName: string = "fabiusT-user-info-east-2";
    private keyName: string = "userId";
    private keyType: string = "S";
    
    constructor() {
        const config = {
            "apiVersions": {
                dynamodb: '2012-08-10'
            },
            "region": "us-east-1"
        };
        this.dynamoDB = new DynamoDB(config);
    }

    private getBaseInfo(key: string, valueObj:T ): any {
        let valueObjSnippet = "";
        if (valueObj){
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

    public async Put(key: string, valueObj: T) {
        // const keyInfoJsonString = `{
        //     "Item": {  
        //             "${this.keyName}": {
        //                 "${this.keyType}": "${key}"
        //             },
        //             "valueObj": {
        //                 "S": ${JSON.stringify(JSON.stringify(valueObj))}
        //             }
        //         },
        //     "ReturnConsumedCapacity": "TOTAL",
        //     "TableName": "${this.tableName}"
        // }`;

        // var params = {
        //     Item: {
        //         userId: {
        //             S: key
        //         },
        //         "valueObj": {
        //             S: JSON.stringify(valueObj)
        //         }
        //     },
        //     ReturnConsumedCapacity: "TOTAL",
        //     TableName: this.tableName
        // };

        const baseInfo = this.getBaseInfo(key, valueObj);
        // baseInfo.Item.valueObj.S = JSON.stringify(valueObj);
        console.log(baseInfo);
        await new Promise<void>((resolve, reject) => {
            this.dynamoDB.putItem(baseInfo, (err, putItemOutput) => {
                if (err) {
                    reject(err);
                }
                console.log("dynamodb put is done");
                resolve();
            });
        });
    }

    public async Get(key: string): Promise<T> {
        // var params = {
        //     ReturnConsumedCapacity: "TOTAL",
        //     TableName: this.tableName,
        //     Key: {
        //         keyName: {
        //             S: key
        //         }
        //     }
        // };
        const queryInfo = this.getBaseInfo(key, null);
        return await new Promise<T>((resolve, reject) => {
            this.dynamoDB.getItem(queryInfo, (err, data) => {
                if (err) {
                    reject(err);
                }
                const jsonObj = JSON.parse(JSON.stringify(data.Item)).valueObj.S;
                console.log("dynamodb get is done");
                resolve(jsonObj);
            });
        });
    }
}

export default DynamoDBService;