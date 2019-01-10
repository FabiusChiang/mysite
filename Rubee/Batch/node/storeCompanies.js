const fs = require('fs');
const util = require('util');

function store(allCompanies) {
    fs.writeFileSync('./data/all.json', JSON.stringify(allCompanies) , 'utf-8');
}

module.exports = store;
