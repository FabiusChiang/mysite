const data = require('./data.json')
const express = require('express')
const app = express()
const port = 3000

var result = [];
var t = 0;

function findFunc (input) {
    for (let i=0; i<data.length; i++){
        const currentRow = data[i];
        const lowerCaseTicker = currentRow.ticker.toLowerCase();
        const lowerCaseName = currentRow.name.toLowerCase();
        if( (lowerCaseTicker.indexOf(input.toLowerCase()) != -1) || (lowerCaseName.indexOf(input.toLowerCase())!= -1)){ //无论是符合ticker还是name，都被看作是符合。
            //用indexOf从头到尾检查lowerCaseTicker中是否含有与input.toLowerCase（变成小写后的input）一样的元素
            result.push(currentRow);
        }
    }
    if(result.length != 0){
        return result;
    }
    else{
        return null;
    }
}

app.get('/', function(req, res) {
    var inputFromWeb = req.query.s;
    result = [];
    result = findFunc(inputFromWeb);
    if(result != null){
        // res.send(result.length + result);
        res.send("The total of your results is: " + result.length + '</br>' + JSON.stringify(result)); //能否换行 //换行成功
    }
    else{
        res.send('error');
    }
    console.log(result.length);
})

app.listen(3000)