"use strict";

const array = [
    {
        key: "2016-11-01",
        value: 1
    },
    {
        key: "2016-11-02",
        value: 2
    },
    {
        key: "2016-11-03",
        value: 3
    }
];


let max = array.length && array.reduce((prev, current) => (prev.key > current.key) ? prev : current);

console.log(max);

const arrayEmpty=[];

max = arrayEmpty.length && arrayEmpty.reduce((prev, current) => (prev.key > current.key) ? prev : current);

console.log(max);