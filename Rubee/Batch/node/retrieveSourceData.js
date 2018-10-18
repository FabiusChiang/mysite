function retrieve() {
    fs.writeFileSync('./data/all.json', JSON.stringify(allCompanies) , 'utf-8');
}

module.exports = retrieve;
