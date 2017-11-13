const express = require('express')
const app = express()

const mockData = require("./mockData.json");
console.log(mockData);


app.get('/', (req, res) => res.send('Hello World!'))
app.get('/api', (req, res) => res.send('Hello World - api!'))

// app.listen(3000, () => console.log('Example app listening on port 3000!'))

const classHello = require("./hello");
const obj1 = new classHello("obj1");
obj1.actionA();

const classPoliteHello = require("./politeHello");
const obj2 = new classPoliteHello("obj2");
obj2.actionA();
obj2.actionB();