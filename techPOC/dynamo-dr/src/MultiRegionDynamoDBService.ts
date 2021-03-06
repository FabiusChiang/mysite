import KeyValueStorage from "./KeyValueStorage";
import IMultiRegionConfig from "./MultiRegionConfig";
import DynamoDBService from "./DynamoDBService";
import safeLoggerWrapper from './safeLoggerWrapper';

class MultiRegionDynamoDBService<T> implements KeyValueStorage<T> {
    private primaryDynamoDBService: DynamoDBService<T>;
    private drDynamoDBServices: Array<DynamoDBService<T>>;
    private keyName: string;
    private keyType: string;

    private logInformation: (infoMsg: string) => any = function (inforMsg: string) {
        console.log(inforMsg);
    }

    private logWarning: (warningMsg: string) => any = function (warningMsg: string) {
        this.logInformation(warningMsg);
    }

    private logError: (errorMsg: string) => any = function (errorMsg: string) {
        this.logWarning(errorMsg);
    }

    constructor(originalConfig: IMultiRegionConfig,
        logInformation: (infoMsg: string) => any = null,
        logWarning: (warningMsg: string) => any = null,
        logError: (errorMsg: string) => any = null) {

        if (logInformation) {
            this.logInformation = safeLoggerWrapper(logInformation);
        }

        if (logWarning) {
            this.logWarning = safeLoggerWrapper(logWarning);
        }

        if (logError) {
            this.logError = safeLoggerWrapper(logError);
        }

        const config = this.validateConfig(originalConfig);
        this.keyName = config.keyName;
        this.keyType = config.keyType;
        const primaryConfig = config.regionConfigs.filter(c => c.primary == true)[0];
        this.primaryDynamoDBService = new DynamoDBService<T>(primaryConfig.tableName, config.keyName, primaryConfig.region, config.keyType, this.logInformation, this.logError);
        const drConfigs = config.regionConfigs.filter(c => c.primary == false);
        this.drDynamoDBServices = new Array<DynamoDBService<T>>();
        drConfigs.forEach(drConfig => {
            const drDynamoDDsvc = new DynamoDBService<T>(drConfig.tableName, config.keyName, drConfig.region, config.keyType, this.logInformation, this.logError);
            this.drDynamoDBServices.push(drDynamoDDsvc);
        });
    }

    public async put(key: string, valueObj: T) {
        let primaryWritePromise;
        try{
            primaryWritePromise = this.primaryDynamoDBService.put(key, valueObj);
        } 
        catch(ex){
            this.logError(`Failed to put data with key ${key} into the primary table ${this.primaryDynamoDBService.TableName} in region ${this.primaryDynamoDBService.Region}`)
        }
        const thisObj = this;
        this.drDynamoDBServices.forEach(drDBsvc => {
            drDBsvc.put(key, valueObj)
                .catch(ex => {
                    thisObj.logWarning(`ailed to put data with key ${key} into the DR table ${drDBsvc.TableName} in region ${drDBsvc.Region}`);
                    thisObj.logWarning(ex);
                });
        });
        await primaryWritePromise;
    }

    public async get(key: string): Promise<T> {
        return await this.primaryDynamoDBService.get(key)
    }

    private validateConfig(originalConfig: IMultiRegionConfig): IMultiRegionConfig {
        const config: IMultiRegionConfig = (JSON.parse(JSON.stringify(originalConfig)));
        config.regionConfigs.forEach(c => {
            if (c.primary != true) {
                c.primary = false;
            }
        });

        const primaryConfigs = config.regionConfigs.filter((c) => c.primary == true);
        const currentRegion = MultiRegionDynamoDBService.getDefaultRegion();
        if (primaryConfigs.length == 0) {
            const tablesInCurrentRegion = config.regionConfigs.filter((c) => c.region === currentRegion);
            if (tablesInCurrentRegion.length > 1) {
                throw Error(`No primary table is defined and there are ${tablesInCurrentRegion.length} tables in the current region (${currentRegion}) per config, can't determine which table should be the primary table.`);
            }
            if (tablesInCurrentRegion.length === 0) {
                throw Error(`No primary table is defined and there is no table in the current region (${currentRegion}) per config, can't determine which table should be the primary table.`);
            }
            if (tablesInCurrentRegion.length === 1) {
                this.logInformation(`No primary table is defined, but the table ${tablesInCurrentRegion[0].tableName} in the current region ${currentRegion} is choosed as the primary table`);
                config.regionConfigs.forEach(c => c.primary = (c == tablesInCurrentRegion[0]));
                return config;
            }
        }

        if (primaryConfigs.length > 1) {
            const primaryConfigInCurrentRegion = primaryConfigs.filter((c) => { c.region === currentRegion });
            if (primaryConfigInCurrentRegion.length === 0 || primaryConfigInCurrentRegion.length > 1) {
                throw Error(`Too many primary tables are defined and failed to filter out a single primary table based on the current region (${currentRegion}), can't determine which table should be the primary table.`);
            }
            this.logInformation(`Too many primary tables are defined, but the table ${primaryConfigInCurrentRegion[0].tableName} in the current region ${currentRegion} is choosed as the unique primary table`);
            config.regionConfigs.forEach(c => c.primary = (c == primaryConfigInCurrentRegion[0]));
            return config;
        }

        return config;
    }

    private static getDefaultRegion(): string {
        return process.env.AWS_REGION || "us-east-1";
    }
}

export default MultiRegionDynamoDBService;