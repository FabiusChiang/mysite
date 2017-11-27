"use strict";

// const array = [
//     {
//         key: "2016-11-01",
//         value: 1
//     },
//     {
//         key: "2016-11-02",
//         value: 2
//     },
//     {
//         key: "2016-11-03",
//         value: 3
//     }
// ];


// let max = array.length && array.reduce((prev, current) => (prev.key > current.key) ? prev : current);

// console.log(max);

// const arrayEmpty=[];

// max = arrayEmpty.length && arrayEmpty.reduce((prev, current) => (prev.key > current.key) ? prev : current);

// console.log(max);

const moment = require("../node_modules/moment");

function convertTime (timeWindow) {
    const years = moment().diff(timeWindow, "years");
    const endDate = moment().subtract(1, "month").endOf("month");
    const startDate = ((years !== 1) ? moment().startOf("year").subtract(years, "years") : moment(endDate).subtract(years, "years")).add(1, "days");
    const format = "YYYY-MM-DD";

    console.log(startDate);
    console.log(endDate);

    return {
        startDate: startDate.format(format),
        endDate: endDate.format(format)
    };
}

let dt = "2017-01-01";
convertTime(dt);

dt = "2016-01-01";
convertTime(dt);