"use strict";

const express = require('express');
const restController = require('./rest_controller');
const fs = require('fs');
const extractContent = require("../services/extractContent.js");

const validDomainRegExp = /^https?:\/\/((localhost)|(([\d-\w]{0,100}.)?fabiuslela.com))(:?\d{2,5})?($|\/|\?)/ig;

class PostsController extends restController {
    constructor(opt) {
        super(opt);
    }

    async get(req, res) {
        const previousHost = this._getCallerHostName(req);
        // const previousHost = "http://localhost:8080";
        if (previousHost) {
            res.setHeader("Content-Type", "text/html; charset=utf-8");
            res.setHeader("Access-Control-Allow-Origin", previousHost);
            const postUrl = req.params.postUrl;
            if (postUrl.match(validDomainRegExp)){
                const content = await extractContent(postUrl);
                res.send(content);
            }
            else{
                this._return403(res);
            }
        }
        else {
            this._return403(res);
        }
    }

    setCustomPath() {
        this.get.customPath = "/:postUrl";
    }

    _return403(res) {
        res.send(403, "Not allowed request");
    }

    _getCallerHostName(req) {
        const referer = req.headers.referer || '';
        const regResult = referer.match(validDomainRegExp);
        const hostName = regResult && regResult[0].replace(/(\/|\?)$/g, '');
        return hostName;
    }
}

module.exports = PostsController;
