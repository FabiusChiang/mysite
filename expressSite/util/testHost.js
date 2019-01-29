"use strict"

// console.log(/ttps:/g.exec("https:https"))

// console.log("https:https".match(/^ttps:/g));

// console.log("https:https".match(/(ttps:)|(htt)/g));


// console.log("http://localhost:8080/".match(/^https?:\/\/localhost:?\w{2,5}/g))

// console.log("http://localhOst:8080/".match(/^https?:\/\/localhost(:?\w{2,5})?/ig))

// console.log("http://localhOst".match(/^https?:\/\/localhost(:?\w{2,5})?/ig))

// console.log("http://localhOst".match(/^https?:\/\/((localhost)|(\w{0,100}.fabiuslela.com))(:?\w{2,5})?/ig))

console.log("https://fabiuslela.com:8080\/hfkdalhkl".match(/^https?:\/\/((localhost)|(([\d-\w]{0,100}.)?fabiuslela.com))(:?\w{2,5})?/ig))

const regResult = "https://i-qa.fabiuslela.com/test=fda".match(/^https?:\/\/((localhost)|(([\d-\w]{0,100}.)?fabiuslela.com))(:?\d{2,5})?($|\/|\?)/ig);
const hostName = regResult && regResult[0].replace(/(\/|\?)$/g, '');
console.log(hostName)