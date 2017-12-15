"use strict";
const stopWatch = require('./util/stop_watch');
const routers = require('./routers');

const express = require('express')
const app = express()

app.get('/', (req, res) => res.send('Hi! This is the API!'))
app.listen(3000, () => console.log('Example app listening on port 3000!'))

routers.applyRouters(app);



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
app.use(require("./controllers/categories_controller"));

//app.use(require("./controllers/test_controller"));
const testController = require("./controllers/test_controller");
const newTestController = new testController();
const testRouter = express.Router();

newTestController.install(testRouter, "/test");


app.use(testRouter);
//router.install("/test", new testController());