"use strict"

import httpGet from '../../../expressSite/services/get.js';

async function getManagedContent(url) {
    const fullUrl = `http://localhost:3000/posts/${encodeURIComponent(url)}`;
    return await httpGet(fullUrl);
}

export default getManagedContent;