<template>
    <!-- <div class="dynamicContent" v-html="introContent"></div> -->
    <!-- <div class="dynamicContent" v-html="managedContent||introContent"></div> -->
    <!-- <div class="dynamicContent" v-html="introContent">{{ getDynamicContent() }}</div> -->
    <div class="dynamicContent" v-html="getDynamicContent()"></div>
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
        ds: this.dataSource,
        introContent: null // "this is the content",
        ,managedContent: null
      }
    },
    // computed: {
    //   managedContent: function(){
    //     const urlOfMangedPage = this.dataSource;
    //     async function getContent () {
    //       try {
    //         let response = await getManagedContent(urlOfMangedPage) ;
    //         return response;
    //       } catch (err) {
    //         console.log(err)
    //       }
    //     };
    //     getContent().then((data) => {
    //       this.introContent = data;
    //     });
    //   }
    //   // managedContent: async function(){
    //   //   const urlOfMangedPage = this.dataSource;
    //   //   return await getManagedContent(urlOfMangedPage) ;
    //   //       return response;
    //   // }
    // }


    // watch: {
    //   dataSource: function(value){
    //     console.log(value);
    //     const urlOfMangedPage = value;
    //     async function getContent () {
    //       try {
    //         let response = await getManagedContent(urlOfMangedPage) ;
    //         return response;
    //       } catch (err) {
    //         console.log(err)
    //       }
    //     }
    //     getContent().then((data) => {
    //       this.introContent = data;
    //     })
    //   }
    // },

    methods: {
      getDynamicContent: async function() {
        const urlOfMangedPage = this.dataSource;
        // async function getContent () {
        //   try {
        //     let response = await getManagedContent(urlOfMangedPage) ;
        //     return response;
        //   } catch (err) {
        //     console.log(err)
        //   }
        // }
        // getContent().then((data) => {
        //   this.introContent = data;
        // });
        return await getManagedContent(urlOfMangedPage);
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
