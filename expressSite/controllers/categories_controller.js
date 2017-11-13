"use strict";

const express = require('express');
const mockData = require("../mockData.json")


const router = express.Router();


class CategoryController{
    get (req, res) {
        const retVal = mockData;
        console.log(retVal);
        res.send(retVal);
    }
}

const controller = new CategoryController();

router.get('/categories', controller.get);

module.exports = router;