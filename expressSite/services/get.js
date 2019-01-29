"use strict"

const http = require('http');

async function get(url){
    // url = 'http://blog.fabiuslela.com/fabiuss-introduction/';
    return new Promise((resolve, reject) => {
        http.get(url, (resp) => {
            let data = '';

            // A chunk of data has been recieved.
            resp.on('data', (chunk) => {
                data += chunk;
            });
            resp.on('end', () => {
                return resolve(data);
            });

        });        
    });
}

export default get;