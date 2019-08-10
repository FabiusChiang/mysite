interface IKeyValueStorage<T> {
    put(key: string, valueObj: T): Promise<void>;

    get(key: string): Promise<T>;
}

export default IKeyValueStorage;