<template>
    <div class="dynamicContent" v-html="introContent">{{ getDynamicContent() }}</div>
</template>

<script>
import httpGet from '../../../expressSite/services/get.js';

async function getManagedContent(url) {
  const fullUrl = `http://localhost:3000/posts/${encodeURIComponent(url)}`;
  return await httpGet(fullUrl);
}

export default {
    props: {
      dataSource: String
    },
    data() {
      return {
        introContent: null
      }
    },
    methods: {
      getDynamicContent: function() {
        console.log("it's called")
        // this.introContent = await getManagedContent(this.dataSource)
        getManagedContent(this.dataSource).then(d => {this.introContent = d});
      }
    }
}
</script>

<style scoped>
/* Below it's the sample about how to change the style of the html element in the dynamic content */
/* .dynamicContent >>> .entry-content {
  
} */
</style>
