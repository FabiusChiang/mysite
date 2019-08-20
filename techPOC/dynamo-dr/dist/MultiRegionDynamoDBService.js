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
const DynamoDBService_1 = require("./DynamoDBService");
class MultiRegionDynamoDBService {
    constructor(originalConfig) {
        const config = MultiRegionDynamoDBService.validateConfig(originalConfig);
        this.keyName = config.keyName;
        this.keyType = config.keyType;
        const primaryConfig = config.regionConfigs.filter(c => c.primary == true)[0];
        this.primaryDynamoDBService = new DynamoDBService_1.default(primaryConfig.tableName, config.keyName, primaryConfig.region, config.keyType);
        const drConfigs = config.regionConfigs.filter(c => c.primary == false);
        this.drDynamoDBServices = new Array();
        drConfigs.forEach(drConfig => {
            const drDynamoDDsvc = new DynamoDBService_1.default(drConfig.tableName, config.keyName, drConfig.region, config.keyType);
            this.drDynamoDBServices.push(drDynamoDDsvc);
        });
    }
    put(key, valueObj) {
        return __awaiter(this, void 0, void 0, function* () {
            const primaryWritePromise = this.primaryDynamoDBService.put(key, valueObj);
            this.drDynamoDBServices.forEach(drDBsvc => {
                drDBsvc.put(key, valueObj)
                    .catch(ex => {
                    console.log(`Failed to put data into ${key}`);
                    console.warn(ex);
                });
            });
            yield primaryWritePromise;
        });
    }
    get(key) {
        return __awaiter(this, void 0, void 0, function* () {
            return yield this.primaryDynamoDBService.get(key);
        });
    }
    static getDefaultRegion() {
        return process.env.AWS_REGION || "us-east-1";
    }
    static validateConfig(originalConfig) {
        const config = (JSON.parse(JSON.stringify(originalConfig)));
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
            const primaryConfigInCurrentRegion = primaryConfigs.filter((c) => { c.region === currentRegion; });
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
exports.default = MultiRegionDynamoDBService;
//# sourceMappingURL=MultiRegionDynamoDBService.js.map