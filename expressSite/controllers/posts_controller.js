"use strict";

const express = require('express');
const restController = require('./rest_controller');
const fs = require('fs');

class PostsController extends restController {
    constructor(opt) {
        super(opt);
    }

    // before(req, res, next) {
    //     const retVal = "This is before test.";
    //     console.log(retVal);
    //     res.setHeader("h1FromTestController", "v1");
    //     next();
    // }

    async get(req, res) {
        res.setHeader("Content-Type", "text/html; charset=utf-8");
        const fileName = "static/" + req.params.postId + ".html";
        fs.readFile(fileName, 'utf8', function(err, contents) {
            // console.log(contents);
            const retVal = contents;
            res.send(retVal);
        });
         
        
        
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

    setCustomPath() {
        this.get.customPath = "/:postId";
    }

}

module.exports = PostsController;
