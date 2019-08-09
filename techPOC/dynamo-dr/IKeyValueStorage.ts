interface IKeyValueStorage<T> {
    Put(key: string, valueObj: T): Promise<void>;

    Get(key: string): Promise<T>;
}

export default IKeyValueStorage;