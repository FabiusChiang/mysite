import IKeyValueStorage from "./IKeyValueStorage";
import { config, DynamoDB } from 'aws-sdk';


class MultiRegionDynamoDBService<T> implements IKeyValueStorage<T> {
    private dynamoDB: DynamoDB;
    private tableName: string;
    private keyName: string;
    private keyType: string;
    
    constructor(tableName: string, keyName: string, region: string, keyType: string = "S") {
        this.tableName = tableName;
        this.keyName = keyName;
        this.keyType = keyType;

        const config = {
            "apiVersions": {
                dynamodb: '2012-08-10'
            },
            "region": region
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

    public async put(key: string, valueObj: T) {
        const baseInfo = this.getBaseInfo(key, valueObj);
        await new Promise<void>((resolve, reject) => {
            this.dynamoDB.putItem(baseInfo, (err, putItemOutput) => {
                if (err) {
                    console.log(err);
                    reject(err);
                }
                console.log("dynamodb put is done");
                resolve();
            });
        });
    }

    public async get(key: string): Promise<T> {
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

export default MultiRegionDynamoDBService;