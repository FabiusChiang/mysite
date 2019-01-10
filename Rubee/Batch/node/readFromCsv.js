const csv = require('fast-csv');
const fs = require('fs');

async function read(csvFilePath) {
    //csvFilePath = "./data/nsdq.csv";
    const stream = fs.createReadStream(csvFilePath);

    let count = 0;
    const resultArray = [];
    return new Promise((resolve, reject) => {
        const csvStream = csv()
            .on("data", function(data){
                count ++;
                if (count == 1) {
                    return;
                }
                const company = {
                    ticker: data[0],
                    name:  data[1],
                }
                resultArray[resultArray.length] = company;
                //console.log(data);
            })
            .on("end", function(){
                return resolve(resultArray);
            });
            stream.pipe(csvStream);
        });
}

module.exports = read;
