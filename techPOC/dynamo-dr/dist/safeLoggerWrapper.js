"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
function safeLoggerWarpper(logFunction) {
    return (message) => {
        try {
            logFunction(message);
        }
        catch (ex) {
            console.log("Failed to write log");
            console.log(ex);
        }
    };
}
exports.default = safeLoggerWarpper;
//# sourceMappingURL=safeLoggerWrapper.js.map