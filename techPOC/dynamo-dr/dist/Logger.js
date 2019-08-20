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
class Logger {
    greetings() {
        return __awaiter(this, void 0, void 0, function* () {
            console.log("greetings is sent.");
        });
    }
    greetingToRemote() {
        return __awaiter(this, void 0, void 0, function* () {
            console.log(this.addTimestamp("Sending a message slowly"));
            yield new Promise(function (resolve, reject) {
                setTimeout(() => {
                    console.log(this.addTimestamp("Sending slow message is done"));
                    resolve();
                }, 1000 * 2);
            });
        });
    }
    getLogInfoFunc() {
        return this.LogInfo.bind(this);
    }
    LogInfo(text) {
        console.log(this.addTimestamp(text));
    }
    LogWarning(text) {
        console.warn(this.addTimestamp(text));
    }
    LogError(text) {
        console.error(this.addTimestamp(text));
    }
    addTimestamp(text) {
        return this.getTime() + ": " + text;
    }
    getTime() {
        const d = new Date();
        return d.toISOString();
    }
}
exports.default = Logger;
//# sourceMappingURL=Logger.js.map