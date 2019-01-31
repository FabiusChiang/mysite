<template>
  <div class="dynamicContent" v-html="pageContent" />
</template>

<script>
import getManagedContent from '../util/getManagedContent.js';

async function loadDynamicContent(vm) {
  console.log("it's called");
  vm.pageContent = await getManagedContent(vm.dataSource);
}

export default {
  props: {
    dataSource: String
  },
  data () {
    loadDynamicContent(this);
    return {
      pageContent: null
    }
  },
  watch: {
    dataSource: function(newVal) {
      loadDynamicContent(this);
      ///vue-async-computed can help to use asyncComputed property.
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
/* Below it's the sample about how to change the style of the html element in the dynamic content */
/* .dynamicContent >>> .entry-content {
  
} */
</style>
