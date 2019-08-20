import KeyValueStorage from "./KeyValueStorage";
import IMultiRegionConfig from "./MultiRegionConfig";
import DynamoDBService from "./DynamoDBService";
import { ECS } from 'aws-sdk';

class MultiRegionDynamoDBService<T> implements KeyValueStorage<T> {
    private primaryDynamoDBService: DynamoDBService<T>;
    private drDynamoDBServices: Array<DynamoDBService<T>>;
    private keyName: string;
    private keyType: string;

    constructor(originalConfig: IMultiRegionConfig) {
        const config = MultiRegionDynamoDBService.validateConfig(originalConfig);
        this.keyName = config.keyName;
        this.keyType = config.keyType;
        const primaryConfig = config.regionConfigs.filter(c => c.primary == true)[0];
        this.primaryDynamoDBService = new DynamoDBService<T>(primaryConfig.tableName, config.keyName, primaryConfig.region, config.keyType);
        const drConfigs = config.regionConfigs.filter(c => c.primary == false);
        this.drDynamoDBServices = new Array<DynamoDBService<T>>();
        drConfigs.forEach(drConfig => {
            const drDynamoDDsvc = new DynamoDBService<T>(drConfig.tableName, config.keyName, drConfig.region, config.keyType);
            this.drDynamoDBServices.push(drDynamoDDsvc);
        });
    }

    public async put(key: string, valueObj: T) {
        const primaryWritePromise = this.primaryDynamoDBService.put(key, valueObj);
        this.drDynamoDBServices.forEach(drDBsvc => {
            drDBsvc.put(key, valueObj)
                .catch(ex => {
                    console.log(`Failed to put data into ${key}`);
                    console.warn(ex);
                });
        });
        await primaryWritePromise;
    }

    public async get(key: string): Promise<T> {
        return await this.primaryDynamoDBService.get(key)
    }

    private static getDefaultRegion(): string {
        return process.env.AWS_REGION || "us-east-1";
    }

    private static validateConfig(originalConfig: IMultiRegionConfig): IMultiRegionConfig {
        const config: IMultiRegionConfig = (JSON.parse(JSON.stringify(originalConfig)));
        config.regionConfigs.forEach(c => {
            if (c.primary != true) {
                c.primary = false;
            }
        });

        const primaryConfigs = config.regionConfigs.filter((c) => c.primary == true);
        const currentRegion = this.getDefaultRegion();
        if (primaryConfigs.length == 0) {
            const tablesInCurrentRegion = config.regionConfigs.filter((c) => c.region === currentRegion);
            if (tablesInCurrentRegion.length > 1) {
                throw Error(`No primary table is defined and there are ${tablesInCurrentRegion.length} tables in the current region (${currentRegion}) per config, can't determine which table should be the primary table.`);
            }
            if (tablesInCurrentRegion.length === 0) {
                throw Error(`No primary table is defined and there is no table in the current region (${currentRegion}) per config, can't determine which table should be the primary table.`);
            }
            if (tablesInCurrentRegion.length === 1) {
                console.log(`No primary table is defined, but the table ${tablesInCurrentRegion[0].tableName} in the current region ${currentRegion} is choosed as the primary table`);
                config.regionConfigs.forEach(c => c.primary = (c == tablesInCurrentRegion[0]));
                return config;
            }
        }

        if (primaryConfigs.length > 1) {
            const primaryConfigInCurrentRegion = primaryConfigs.filter((c) => { c.region === currentRegion });
            if (primaryConfigInCurrentRegion.length === 0 || primaryConfigInCurrentRegion.length > 1) {
                throw Error(`Too many primary tables are defined and failed to filter out a single primary table based on the current region (${currentRegion}), can't determine which table should be the primary table.`);
            }
            console.log(`Too many primary tables are defined, but the table ${primaryConfigInCurrentRegion[0].tableName} in the current region ${currentRegion} is choosed as the unique primary table`);
            config.regionConfigs.forEach(c => c.primary = (c == primaryConfigInCurrentRegion[0]));
            return config;
        }

        return config;
    }
}

export default MultiRegionDynamoDBService;