const data = require('./data.json')
const express = require('express')
const app = express()
const port = 3000

var result = [];

function findFunc (input) {
    for (let i=0, t=0; i<data.length; i++){
        const currentRow = data[i];
        // console.log(data[0]); //为什么console.log(data[0])会显示175个{"ticker":"YI","name":"111, Inc."}？
        // console.log("----------");
        // console.log(currentRow);
        // console.log(data.length); //为什么会显示175个6582
        const lowerCaseTicker = currentRow.ticker.toLowerCase();
        const lowerCaseName = currentRow.name.toLowerCase();
        if( (lowerCaseTicker.indexOf(input.toLowerCase()) != -1) || (lowerCaseName.indexOf(input.toLowerCase())!= -1)){ //无论是符合ticker还是name，都被看作是符合。
            //用indexOf从头到尾检查lowerCaseTicker中是否含有与input.toLowerCase（变成小写后的input）一样的元素
            // console.log(currentRow); //currentRow被找到的那一个
            // return currentRow;
            t = t+1; //t表示符合要求的个数
            // console.log(t);
            result.push(currentRow);
            // for(; currentRow != data[data.length+1]; ){
            //     result.push(currentRow); //add at the end
            // }
            return result;
        }
        // return currentRow;
    }
    return null;
}


app.get('/', function(req, res) {
    var inputFromWeb = req.query.s;
    var foundResult = findFunc(inputFromWeb); //foundResult包含一整个obj
    if(foundResult != null){
        // res.send(foundResult.ticker);
        res.send(foundResult);
    }
    else{
        res.send('error');
    }
    console.log(JSON.stringify(foundResult));
})//可达到将其中一个符合要求的结果输出，接下来需要把所有符合的结果罗列出来，需要更改判断的语句

app.listen(3000)

//要解决页面在输入s之前的出错问题: TypeError: Cannot read property 'toLowerCase' of undefined