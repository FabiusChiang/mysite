interface SingleRegionConfig {
    tableName: string;
    region: string;
    primary?: boolean;
}

export default interface MultiRegionConfig {
    keyName: string;
    keyType: string;
    regionConfigs: Array<SingleRegionConfig>;
}