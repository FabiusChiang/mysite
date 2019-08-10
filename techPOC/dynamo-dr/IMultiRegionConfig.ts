export interface SingleRegionConfig {
    tableName: string;
    region: string;
}

export default interface MultiRegionConfig {
    keyName: string;
    keyType: string;
    regionConfigs: Array<SingleRegionConfig>;
    primaryRegion: string;
}