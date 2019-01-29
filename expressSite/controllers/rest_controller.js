"use strict";

var BaseController = require("./base_controller"),
    _ = require("lodash"),
    //fn = require("../util/fn"),
    //types = require("../util/service").lookup("Types"),
    util = require("util");

/**
 * @class REST resource controller
 *
 * @summary Provides an Express router standardized for providing REST resources.
 *
 * | Verb   | Path             | Method  |
 * | ------ | ---------------- | ------- |
 * | GET    | /photos/:id      | get     |
 * | GET    | /photos/:id/edit | edit    |
 * | PUT    | /photos/:id      | update  |
 * | DELETE | /photos/:id      | destroy |
 *
 * @param {object} opts Options for this controller
 * @param {object} opts.logger A logger instance configured
 * for this controller
 * @param {boolean} opts.validateResponse Ensure that the response is validated
 * @param {boolean} opts.disableCaching Adds HTTP cache headers to
 * disable all caching. Defaults to true.
 * @extends {BaseController}
 */
function RESTController(opts) {
    BaseController.call(this, opts);

    /**
     * Middleware that requires the request to have a valid user (from the session).
     * Also, when installed, this will automatically set a userId variable to the
     * context for use in control methods.
     */
    const validateAuthentication = (req, res, next) => {
        //req.logger.trace("Checking access...");

        //if (!req.user) {
        //    req.logger.warn("User information not available. Denying access to resource");
        //    res.status(401).send({
        //        error: "Not Logged In"
        //    });
        //    return;
        //}

        //req.context.userId = req.user._id;
        //if (req.session) {
        //    req.context.sessionId = req.session.id;
        //}
        //req.logger.trace("setting user id to ", req.context.userId);
        next();
    };

    var settings = _.merge({}, {
        disableCaching: true,
        validateResponse: true,
        authFunction: validateAuthentication,
        requireAuth: true,
        sendError: true,
        addLoggerContext: true,
        enableDescribe: true  /* include in resource metadata */
    }, opts);

    this.model = settings.model;
    this.logger = settings.logger;
    this.enableDescribe = settings.enableDescribe;

    if (settings.addLoggerContext) {
        this.use(this.addLogToRequest(this.logger));
    }
    if (settings.authFunction) {
        this.authFunction = settings.authFunction;
    }
    if (settings.requireAuth) {
        this.enableAuthFilter();
    }
    if (settings.disableCaching) {
        this.use(this.disableCaching);
    }
    
    this.use(this.addHeaders);

    if (settings.validateResponse) {
        this.addValidationFilters();
    }
    if (settings.sendError) {
        this.addSendError();
    }
}

RESTController.prototype = Object.create(BaseController.prototype);
RESTController.prototype.constructor = RESTController;

BaseController.prototype.addHeaders = function (req, res, next) {
    // res.header("Access-Control-Allow-Origin", "http://local.fabiuslela.com:8080; https://www.fabiuslela.com");
    next();
};
/**
 * Returns metadata about this controller in order
 * to describe the available routes provided.
 *
 * @return {Object}
 */
RESTController.prototype.describe = function () {
    var resources = [];
    Object.getOwnPropertyNames(this).forEach(function (key) {
        var handler = this[key];
        if (typeof handler === "function" &&
            handler._annotations &&
            handler._annotations.resourceKey) {

            var describe = {
                key: handler._annotations.resourceKey
            };

            if (handler._annotations.schema) {
                describe.schema = handler._annotations.schema.describe();
            }

            resources.push(describe);
        }
    }.bind(this));
    return resources;
};

RESTController.prototype.setCustomPath = function () {
    ///Just a empty function, the subclass can implement the function to define the 
    ///path of action
    ///A sample: this.get.customPath = "/:customizedId";
}

/**
 * Install adds this controller to the parent route using the defined
 * path. In the case of the RESTController, it also automatically looks
 * for well-defined methods and creates routes for them. Based on the
 * Express MVC example.
 *
 * @see BaseController.install
 */
RESTController.prototype.install = function (parentRouter, path) {
    BaseController.prototype.install.apply(this, arguments);

    // combine prototype functions and properties
    // this is to support ES6 classes as well as ES5 objects
    var prototypeFunctions = Object.getOwnPropertyNames(Object.getPrototypeOf(this));
    var properties = Object.getOwnPropertyNames(this);

    // omit non-functions
    // omit notImplemented
    var combinedProperties = _.chain(prototypeFunctions.concat(properties))
        .filter(function (key) {
            var fn = this[key];
            return _.isFunction(fn) && fn !== RESTController.notImplemented;
        }.bind(this))
        .value();

    this.setCustomPath();

    combinedProperties.forEach(function (key) {
        var method, path;

        // route exports
        switch (key) {
            case "get":
                method = "get";
                path = "/:id";
                break;
            case "edit":
                method = "get";
                path = "/:id/edit";
                break;
            case "update":
                method = "put";
                path = "/:id";
                break;
            case "create":
                method = "post";
                path = "/";
                break;
            case "index":
                method = "get";
                path = "/";
                break;
            case "destroy":
                method = "delete";
                path = "/:id";
                break;
            default:
                return;
        }

        // setup
        var handler = this[key];
        if (handler) {
            if (handler.customPath) {
                path = handler.customPath;
            }

            handler._annotations = _.merge({}, {
                resourceKey: key,
                method: method,
                path: path
            }, handler._annotations || {});
        }

        if (!handler) {
            return;
        }

        var before = function (req, res, next) {
            req.resourceKey = key;
            req.annotations = handler._annotations;
            next();
        }.bind(this);

        ////before middleware support
        if (this.before) {
            //this.logger.trace(util.format("Route setup: %s %s -> before -> %s", method.toUpperCase(), path, key));
            this.router[method](path, this.before.bind(this), before, handler.bind(this));
        } else {
            //this.logger.trace(util.format("Route setup: %s %s -> %s", method.toUpperCase(), path, key));
            this.router[method](path, before.bind(this), handler.bind(this));
        }
    }.bind(this));
};


/**
 * Annotate controller functions.
 * @deprecated Use Core.Util.fn.annotatedFn version.
 * @see CoreUtil.fn.annotated
 */
//RESTController.annotatedFn = fn.annotated;

/**
 * Implement this method to provide the index route, which would
 * be a GET of the primary resource URL (e.g. GET /photos).
 * @type {Function}
 * @virtual
 */
//RESTController.prototype.index = notImplemented().setMethod("index");

/**
 * Implement this method to provide a new instance of a resource, which
 * would be a GET of the primary resource URL (e.g. GET /photos/new).
 * @type {Function}
 * @virtual
 */
//RESTController.prototype.new = notImplemented().setMethod("new");

/**
 * Implement this method to save an initial resource, which would
 * be a POST of the primary resource URL (e.g. POST /photos).
 * @type {Function}
 * @virtual
 */
//RESTController.prototype.create = notImplemented().setMethod("create");

/**
 * Implement this method to save an initial resource, which would
 * be a POST of the primary resource URL (e.g. POST /photos).
 * @type {Function}
 * @virtual
 */
//RESTController.prototype.destroy = notImplemented().setMethod("del");

/**
 * Logs a debugging message including user ID information of
 * current controller context.
 */
RESTController.prototype.debug = function () {
    var _this = this;
    this.logger.forContext({
        user: _this.req.user.id
    }).debug.apply(this.logger, arguments);
};

/**
 * Adds middleware that allows endpoints on this resource to
 * be accessed from any domain.
 *
 * @param {object} corsOptions Options for express-cors
 */
RESTController.prototype.cors = function (corsOptions) {
    this.use(require("cors")(corsOptions));
};

/**
 * Applies middleware to this controller to enable validated
 * responses.
 *
 * @see validateJsonResponse
 */
RESTController.prototype.addValidationFilters = function () {
    this.use(this.validateJsonResponse);
};

/**
 * Express middleware that replaces the 'json'
 * method of the Express Response object
 * in order to apply validation to the object. The schema used
 * to validate the response is controlled by the 'schema'
 * annotation applied to the controller method. Keeps the raw 'json'
 * method available as '_json'
 */
RESTController.prototype.validateJsonResponse = function (req, res, next) {
    // make sure this can't doesn't get
    // applied multiple times
    if (res.json.__type !== "validator") {
        var jsonFn = res.json;
        // keep the old 'json' function.
        if (!jsonFn.__type) {
            res._json = jsonFn;
        }
        res.json = function (data) {
            //var schema = req.annotations.schema;
            //if (data === undefined) {
            //    throw new Error("Undefined object sent for validation.");
            //} else if (schema === undefined) {
            //    throw new Error("No schema defined.");
            //} else {
            //    var results = types.validate(data, schema);
            //    if (results.error) {
            //        res.error(results.error);
            //    } else {
            //        jsonFn(data);
            //    }
            //}
            jsonFn(data);
        };
        res.json.__type = "validator";
    }

    return next();
};

/**
 * Applies a global filter to this controller that requires the
 * request to have a valid user (from the session). Also, when
 * installed, this will automatically set a userId variable to the
 * controller context for use in control methods.
 */
RESTController.prototype.enableAuthFilter = function () {
    this.use(this.authFunction);
    return this;
};

/**
 * Log an error. Importantly, this call supports checking
 * for a client trace header sent by the client-side that includes
 * the place in the client code that caused the problem. This error
 * will be de-obfuscated using press-corp.
 *
 * @param {Error} error The error to log
 * @param {String} msg Optional message
 */
RESTController.logError = function (err, msg, req) {
    req.logger.error(msg, err);

    var stackTrace = req.get("x-client-trace");
    if (stackTrace) {
        // if press-corp is available, then use it to
        // de-obfuscate the stack trace
        try {
            stackTrace = decodeURIComponent(stackTrace);
            stackTrace = require("press-corp").deobfuscate(stackTrace);
        } catch (e) {
            req.logger.warn("Couldn't decode client trace", e.message, e.stack);
        }
        req.logger.error("Associated client stack:\n" + stackTrace);
    }
};

/**
 * For backwards compatibility. Doesn't need to exist on instances.
 * @deprecated
 */
RESTController.prototype.logError = RESTController.logError;

/**
 * Creates a middleware function that puts a property called
 * logger onto the request object.
 *
 * @param  {object} logger [description]
 * @return {function}      Middleware function
 */
RESTController.prototype.addLogToRequest = function (logger) {
    return function (req, res, next) {
        req.logger = logger;
        next();
    };
};

/**
 * Adds middleware that adds a 'error' method to the response that both logs
 * the error and sends a JSON-formatted error description back to client.
 */
RESTController.prototype.addSendError = function () {
    this.use(RESTController.sendError);
};

/**
 * Middleware that adds an error function to response objects.
 */
RESTController.sendError = function (req, res, next) {
    /**
     * Send an error as the HTTP response. Defaults to sending a generic
     * 400, but you can change this.
     *
     * @augments Express.Response
     *
     * @param  {object/string}  err     An error object or message
     * @param  {number}         code    The HTTP code to use (default 400)
     */
    res.error = function (err, code) {
        RESTController.logError(err, "", req);

        var errMsg = "",
            stack = "";
        if (typeof err === "object") {
            errMsg = err.toString();
            stack = JSON.stringify(err.stack, null, " ");
        } else if (typeof err === "string") {
            errMsg = err;
        } else {
            errMsg = "Unknown error";
        }

        res.status(code || 400)._json({
            ___type: "error",
            stackTrace: stack,
            error: errMsg
        });
    };

    next();
};

/**
 * @deprecated why does this exist?
 */
//RESTController.prototype.parseJson = fn.deprecated(function (results) {
//    var json = JSON.parse(results.body);
//    return json;
//}, function (msg) {
//    this.logger.warn(msg);
//});

RESTController.prototype.handleCSRFError = function (req, res) {
    res.send(403);
};

module.exports = RESTController;
