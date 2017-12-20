"use strict";

const express = require('express');
const restController = require('./rest_controller');


class PublicController extends restController {
    constructor(opt) {
        super(opt);
    }

    before(req, res, next) {
        const retVal = "This is before test.";
        console.log(retVal);
        res.setHeader("publicController", "v1");
        next();
    }

    get(req, res) {
        const retVal = "This is public: " + req.params.pubContent;
        console.log(retVal);
        res.send(retVal);
    }

    setCustomPath() {
        this.get.customPath = "/:pubContent";
    }
}

module.exports = PublicController;
