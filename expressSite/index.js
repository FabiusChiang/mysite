"use strict";
const stopWatch = require('./util/stop_watch');
const routers = require('./routers');

const express = require('express')
const app = express()

app.listen(3000, () => console.log('Example app listening on port 3000!'))

routers.applyRouters(app);



app.use(require("./controllers/categories_controller"));
