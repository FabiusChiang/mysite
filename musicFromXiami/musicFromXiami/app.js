'use strict';

//const request = require("superagent");
//const fs = require("fs");

//console.log('Hello world');



////const url = "http://www.xiami.com/play?ids=/song/playlist/id/143408%2C143399%2C376455%2C1772584784%2C1772475511%2C1774893810%2C1772577564%2C143391%2C2072966%2C376378/object_name/default/object_id/0#loaded";
//const url = "http://m128.xiami.net/132/2132/11655/376455_24870_l.mp3?auth_key=1519009200-0-0-096b0601c92a5cd5bf84184354e3ef27";

//request.get(url)
//    .end((err, res) => {
//        console.log(res);
//        fs.appendFile('./ia.txt', res.text, (err) => {
//            if (err) throw err;
//            console.log('The "data to append" was appended to file!');
//        });

//    });



const { Builder, By, Key, until, Capabilities } = require('selenium-webdriver');
const chrome = require('selenium-webdriver/chrome');

(async function example() {
    const chromeCapabilities = Capabilities.chrome();
    chromeCapabilities.set('chromeOptions',
        {
            'args': [
                "--load-extension=/workspace/mysite/musicFromXiami/musicFromXiami/testData/UnblockYouku-3.6.14_0,/workspace/mysite/musicFromXiami/musicFromXiami/testData/SoundPirate-1.9.0_0",
                //"--load-extension=/workspace/mysite/musicFromXiami/musicFromXiami/testData/SoundPirate-1.9.0_0",
                "--disable-web-security"]
            //, 
            //'extensions': ["/workspace/mysite/musicFromXiami/musicFromXiami/testData/SoundPirate.crx"]
        }
    );
    //"C:\workspace\mysite\musicFromXiami\musicFromXiami\testData"


    const chromeOptions = new chrome.Options().headless();
    //chromeOptions.addExtensions(
    //    [
    //        "C:/workspace/mysite/musicFromXiami/musicFromXiami/testData/SoundPirate.crx"
    //    ]);
    chromeOptions.addArguments([
        //"--profile-directory=Default",
        //"--user-data-dir=C:/workspace/mysite/musicFromXiami/musicFromXiami/testData/EmptyProfile",
        "--start-maximized"
    ]);


    let driver = await new Builder()//.forBrowser('chrome')
        //.setChromeOptions(chromeOptions)
        .withCapabilities(chromeCapabilities)
        .build();
    try {
        let url = 'http://www.xiami.com/collect/354466786?spm=a1z1s.3065917.6862697.91.wxs1XL';
        url = 'http://www.xiami.com/collect/2352110?spm=a1z1s.3065917.6862697.123.wxs1XL';
        url = "http://www.xiami.com/collect/10867107?spm=a1z1s.3065917.0.0.lcGbtR";
        url = "http://www.xiami.com/collect/200060452?spm=a1z1s.3065917.6862697.80.NqDdKx";
        url = "http://www.xiami.com/collect/11343797?spm=a1z1s.3065917.6862697.51.NqDdKx";
        url = "http://www.xiami.com/collect/2209601?spm=a1z1s.3065917.6862697.21.v5wxz0";
        url = "http://www.xiami.com/collect/207608918?spm=a1z1s.3065917.6862697.131.v5wxz0";
        await driver.get(url);
        //await driver.findElement(By.name('q')).sendKeys('webdriver', Key.RETURN);
        //await driver.wait(until.titleIs('webdriver - Google Search'), 100000);

        const playButton = await driver.findElement(By.className("cd2play"));
        await playButton.click();

        const tabs = await driver.getAllWindowHandles();
        driver.switchTo().window(tabs[1]);
        await driver.sleep(10000);

        while (true) {
            //await driver.wait(Promise.resolve(false), 8000);
            //await driver.wait(new Promise(() => {
            //    setTimeout(() => {
            //        return false;
            //    }, 5000);
            //}), 5000);
            await driver.sleep(2000);

            const downloadButtons = await driver.findElements(By.tagName("img"));
            for (let i = 0; i < downloadButtons.length; i++) {
                const dbtn = downloadButtons[i];
                const src = await dbtn.getAttribute("src");
                const text = await dbtn.getText();
                if (src == "chrome-extension://idleenniidjlnmnjkjmmnocnkmjibadd/images/music32.png") {
                    await dbtn.click();
                    console.log("hit!");
                    break;
                }
            }

            const aLink = await driver.findElement(By.id("J_nextBtn"));
            await aLink.click();
        }


        //const playButton2 = await driver.findElement(By.className("cd2play"));
        //await playButton2.click();

        console.log("normal");
    }
    catch (error) {
        console.log(error);
    }
    finally {
        await driver.quit();
    }
})();