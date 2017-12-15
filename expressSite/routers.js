"use strict";

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

function setStaticRouter() {
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

function setGlobalRouter() {
    //globalRouter.all("/", (req, res, next) => {
    //    const startTime = stopWatch.getStartTime();
    //    req.on("end", function (result) {
    //        const elaspedTime = stopWatch.getElaspedSecondes(startTime);
    //        const currentTime = new Date();
    //        console.log(`${currentTime.toISOString()}: url="${req.originalUrl}" costTime="${elaspedTime}s"`);
    //    });

    //    next();
    //});
}

function setPublicRouter() {

}

function setPrivateRouter() {

}

//app.get('/', (req, res) => res.send('Hi! This is the API!'))
//app.listen(3000, () => console.log('Example app listening on port 3000!'))






//app.use(express.Router().all("/"), function(req, res, next){
//    const startTime = stopWatch.getStartTime();
    
//    req.on("end", function(result){
//        const elaspedTime = stopWatch.getElaspedSecondes(startTime);
//        const currentTime = new Date();
//        console.log(`${currentTime.toISOString()}: url="${req.originalUrl}" costTime="${elaspedTime}s"`);
//    });

//    // res.on('finish', function() {
//    //     const elaspedTime = stopWatch.getElaspedSecondes(startTime);
//    //     console.log(elaspedTime);
//    //     res.setHeader("ContentType", "application/json");
//    // });

//    next();
//});
//app.use(require("./controllers/categories_controller"));

////app.use(require("./controllers/test_controller"));
//const testController = require("./controllers/test_controller");
//const newTestController = new testController();
//const testRouter = express.Router();

//newTestController.install(testRouter, "/test");


//app.use(testRouter);
////router.install("/test", new testController());

function applyRouters(app) {
    //app.use("/static", staticRouter);

    //app.use("/", setGlobalRouter);


    app.use(function(req, res, next){
        const startTime = stopWatch.getStartTime();

        req.on("end", function(result){
            const elaspedTime = stopWatch.getElaspedSecondes(startTime);
            const currentTime = new Date();
            console.log(`${currentTime.toISOString()}: url="${req.originalUrl}" costTime="${elaspedTime}s"`);
        });

        // res.on('finish', function() {
        //     const elaspedTime = stopWatch.getElaspedSecondes(startTime);
        //     console.log(elaspedTime);
        //     res.setHeader("ContentType", "application/json");
        // });

        next();
    });
}

module.exports.applyRouters = applyRouters;