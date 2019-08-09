import { config, DynamoDB } from 'aws-sdk';
import { resolve } from 'path';


class UserStatusManager {
    private dynamoDB: DynamoDB;

    constructor() {
        // config.apiVersions = {
        //     dynamodb: '2012-08-10'
        // };
        // config.region = "us-east-1";
        const config = {
            "apiVersions": {
                dynamodb: '2012-08-10'
            },
            "region": "us-east-1"
        };
        this.dynamoDB = new DynamoDB(config);
    }
    public async Put() {
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
                        "Name": { S: "Joe"},
                        "Age": {N: "29"}
                    }
                }
            },
            ReturnConsumedCapacity: "TOTAL",
            TableName: "fabiusTestEast"
        };

        // this.dynamoDB.putItem(params, (err, putItemOutput) => {
        //     console.log(err);
        //     console.log(putItemOutput);

        //     console.log("dynamodb call is done");
        // });

        await new Promise<void> ((resolve, reject) => {
            this.dynamoDB.putItem(params, (err, putItemOutput) => {
                console.log(err);
                console.log(putItemOutput);
    
                console.log("dynamodb call is done");
                resolve();
            });
        });


    }

    public async Get() {

    }

}

export default UserStatusManager;