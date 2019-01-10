"use strict";

import msg from "./testImport";


const express = require('express');
const stopWatch = require('./util/stop_watch');

let staticRouter = null;
const globalRouter = express.Router();
const publicRouter = express.Router();
const privateRouter = express.Router();

setStaticRouter();
setGlobalRouter();
setPublicRouter();
setPrivateRouter();

function setStaticRouter () {
    var options = {
        dotfiles: 'ignore',
        etag: false,
        extensions: ['htm', 'html', 'css', 'svg', 'js', 'png'],
        index: false,
        maxAge: '1d',
        redirect: false,
        setHeaders: function (res, path, stat) {
            res.set('x-timestamp', Date.now())
        }
    }
    staticRouter = express.static("static", options);
}

function setGlobalRouter () {
    globalRouter.use((req, res, next) => {
        const startTime = stopWatch.getStartTime();
        req.on("end", function (result) {
            const elaspedTime = stopWatch.getElaspedSecondes(startTime);
            const currentTime = new Date();
            // import msg from "./testImport";
            console.log(msg());
            console.log(`${currentTime.toISOString()}: url="${req.originalUrl}" costTime="${elaspedTime}s"`);
        });
        next();
    });
}

function setPublicRouter () {
    const publicController = require("./controllers/public_controller");
    const newController = new publicController();
    newController.install(publicRouter, "/public");
}

function setPrivateRouter () {
    privateRouter.use((req, res, next) => {
        let userId = null;
        if (req.headers.cookie) {
            userId = req.headers.cookie.userId;
        }
        //The context could be prepared here
        next();

        //if (userId) {
        //    next();
        //}
        //else {
        //    res.setHeader("Set-Cookie", "userId=aFakeUserId");
        //    //next(error);
        //    res.send("Login is done, please refresh your page");
        //}
    });

    const testController = require("./controllers/test_controller");
    const newTestController = new testController();
    newTestController.install(privateRouter, "/test");

    const postsController = require("./controllers/posts_controller");
    const newPostsController = new postsController();
    newPostsController.install(privateRouter, "/posts");
}

function applyRouters (app) {
    app.use("/", globalRouter);
    app.use("/static", staticRouter);
    app.use("/", publicRouter);
    app.use("/", privateRouter);
}

module.exports.applyRouters = applyRouters;