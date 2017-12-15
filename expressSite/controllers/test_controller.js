"use strict";

const express = require('express');
const restController = require('./rest_controller');

const router = express.Router();


class TestController extends restController {
    constructor(opt) {
        super(opt);
        this.count = 0;
        console.log("this.count" + this.count);
    }
    
    before (req, res, next) {
        const retVal = "This is before test.";
        console.log(retVal);
        res.setHeader("h1", "v1");
        next();
    }

    get(req, res) {
        //if (this.count) {
            
        //}
        //else {
        //    this.count = 1;
        //}
        //const retVal = "This is test " + count;
        const retVal = "This is test " + this._cal();
        console.log(retVal);
        res.send(retVal);
    }

    _cal() {
        this.count++;
        return this.count;
    }

    //getRouter (req, res) {
    //    const retVal = "This is test";
    //    console.log(retVal);
    //    res.send(retVal);
    //}

    setCustomPath () {
        this.get.customPath = "/:newId";
    }

    //setCustomPath();
}

//const controller = new TestController();

//router.get('/test', controller.get);

module.exports = TestController;