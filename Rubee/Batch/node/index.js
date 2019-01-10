const readFromCvs = require('./readFromCsv');
const storeCompanies = require('./storeCompanies');

async function main() {
    const dataOfNSDQ = await readFromCvs("./data/nsdq.csv");
    const dataOfNY = await readFromCvs("./data/ny.csv");
    const allCompanies = dataOfNSDQ.concat(dataOfNY)
    console.log(allCompanies.length);
    storeCompanies(allCompanies);
}

main();

