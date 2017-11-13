"use strict";
const stopWatch = require('./util/stop_watch');

const express = require('express')
const app = express()

app.get('/', (req, res) => res.send('Hi! This is the API!'))
app.listen(3000, () => console.log('Example app listening on port 3000!'))






app.use(express.Router().all("/"), function(req, res, next){
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
app.use(require("./controllers/categories_controller"));