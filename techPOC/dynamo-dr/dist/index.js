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
const hello_1 = require("./hello");
const dynamoDBService_1 = require("./dynamoDBService");
class Index {
    static main() {
        return __awaiter(this, void 0, void 0, function* () {
            console.log("Main function is called");
            const helloObj = new hello_1.default();
            yield helloObj.greetings();
            yield helloObj.greetingToRemote();
            yield this.dynamoDBSpike();
            console.log("Main function ends");
        });
    }
    static dynamoDBSpike() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const userInfoO = {
                    id: "FE48822D-BF50-44A1-9CE0-61B06504D726",
                    status: "3no_aggregation"
                };
                const dbService = new dynamoDBService_1.default();
                yield dbService.Put(userInfoO.id, userInfoO);
                const userInfo = yield dbService.Get(userInfoO.id);
                console.log(userInfo);
            }
            catch (ex) {
                console.log(ex);
            }
        });
    }
}
Index.main();
//# sourceMappingURL=index.js.map