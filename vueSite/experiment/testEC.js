const extractContent=require('./extractContent');


async function test(){
    const result = await extractContent('http://blog.fabiuslela.com/fabiuss-introduction/');

    console.log(result);
}

test();