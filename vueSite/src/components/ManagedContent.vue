<template>
    <div class="dynamicContent" v-html="introContent"></div>
</template>

<script>
import httpGet from '../../../expressSite/services/get.js';

async function getManagedContent(url) {
  const fullUrl = `http://localhost:3000/posts/${encodeURIComponent(url)}`;
  return await httpGet(fullUrl);
}

export default {
    // name: 'ManagedContent',
    data() {
      async function getContent () {
        try {
          let response = await getManagedContent('http://blog.fabiuslela.com/fabiuss-introduction/') ;
          return response;
        } catch (err) {
          console.log(err)
        }
      }
      getContent().then((data) => {
        this.introContent = data;
      })
      return {
        introContent: null // "this is the content"
      }
    }
}
</script>

<style scoped>
h1, h2 {
  font-weight: normal;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
iframe {
  width: 100%;
  height: 800px;
}
.dynamicContent >>> .entry-content {
  text-align: left;
}
</style>
