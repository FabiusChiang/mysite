<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <h4>{{ dynamicContentM() }}</h4>
  </div>
</template>

<script>
import httpGet from '../../../expressSite/services/get.js';

let count = 0;
function getCount(){
  return count++;
}

export default {
  name: 'HelloWorld',
  props: {
    dataSource: String
  },
  data () {
    return {
      msg: 'Welcome to Your Vue.js App',
      content1: this.dataSource + getCount()
    }
  },
  computed: {
    dynamicContent: function(){
      console.log("test is called")
      return this.dataSource + getCount();
    }
  },
  methods: {
    dynamicContentM: function(){
      console.log("test is called")
      httpGet("test")
        .then(d => {
          this.msg = "then"
        })
        // .catch(ex => {
        //   this.msg = "catch"
        // })
      return this.dataSource + getCount();
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
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
</style>
