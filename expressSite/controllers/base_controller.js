"use strict";

// var config = require("../config"),
//     logger = require("../util/logger").getLogger(__filename),
//     csurf = require("csurf"),
//     fn = require("../util/fn"),
//     express = require("express");
const express = require("express");

/**
 * Creates a controller object to serve HTTP requests.
 *
 * @constructor
 * @param opts {Object} An object containing configuration parameters.
 * @param opts.logger {Logger} A logger instance for the controller to use for logging
 * @param opts.csrf {boolean} If false, disables CSRF token protection on this controller's endpoints.
 */
function BaseController(opts) {
    //this.logger = opts.logger;
    this.router = express.Router();
    //if (opts.csrf !== false) {
    //    this.enableCsrf();
    //}
}

function delegateToChildObjectProperty(property, method) {
    return function () {
        return this[property][method].apply(this[property], arguments);
    };
}

var delegateToInternalRouter = function (method) {
    return delegateToChildObjectProperty("router", method);
};

/**
 * Exposes Express.Router.use
 */
BaseController.prototype.use = delegateToInternalRouter("use");

/**
 * Exposes Express.Router.all
 */
BaseController.prototype.all = delegateToInternalRouter("all");

/**
 * Installs a controller onto a parent router using a
 * base path.
 *
 * @param  {Express.Router} parentRouter
 * @param  {string}         path
 */
BaseController.prototype.install = function (parentRouter, path) {
    parentRouter.use(path, this.router);
};

/**
 * Log an error
 * @param {Error} error The error to log
 * @param {String} msg Optional message
 */
BaseController.prototype.logError = function (err, msg) {
    //this.logger.error(msg, err);

    //var stackTrace = this.req.get("x-client-trace");
    //if (stackTrace) {
    //    // if press-corp is available, then use it to
    //    // de-obfuscate the stack trace
    //    try {
    //        stackTrace = require("press-corp").deobfuscate(stackTrace);
    //    } catch (e) {}
    //    this.logger.error("Associated client stack:\n" + stackTrace);
    //}
};

//BaseController.prototype.getCSRFMiddleware = function () {
//    var csurfFn = csurf();

//    return function csrfToken(req, res, next) {
//        csurfFn(req, res, function () {
//            res.locals._csrf = req.csrfToken();
//            next();
//        });
//    };
//};

BaseController.prototype.getCSRFErrorHandler = function () {
    //return function csrfError(err, req, res, next) {
    //    if (err && err.status === 403) {
    //        logger.warn("CSRF token not validated. Handling the CSRF Error");
    //        this.handleCSRFError(req, res);
    //        return;
    //    }
    //    next(err);
    //}.bind(this);
};

/**
 * Enables CSRF protection on this controller's resources, but only if
 * the global security.csrf.enabled property isn't disabled. Each request
 * object in the controller will get a "_csrf" property set with the
 * token, which must be sent in the header for REST calls or a <form> input
 * for standard url-encoded posts.
 *
 * If the token isn't valid, this will redirect users to the URL specified
 * by "security.csrf.redirect"
 */
BaseController.prototype.enableCsrf = function () {
    //if (config.is("security:csrf:enabled")) {
    //    this.use(this.getCSRFMiddleware());
    //    // error middleware to detect CSRF problems
    //    // and redirect to login page with a special
    //    // warning
    //    this.use(this.getCSRFErrorHandler());
    //}
};

/**
 * Set cache control headers to disable the cache completely.
 *
 * TODO: micro-library for this?
 *
 * @param  {Request}   req  [description]
 * @param  {Response}}   res  [description]
 * @param  {Function} next [description]
 */
BaseController.prototype.disableCaching = function (req, res, next) {
    //res.header("Cache-Control", "no-cache, no-store, must-revalidate");
    //res.header("Pragma", "no-cache");
    //res.header("Expires", 0);
    next();
};

module.exports = BaseController;
