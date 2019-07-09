<template>
    <div class="col-sm-8">
      
        <h2>Fabius introduction</h2>
        <h5>Title1 description, Dec 7, 2017</h5>
        <div class="fakeimg">Fake Image</div>
        <div class="pageBody">
          <managedContent v-bind:dataSource="url" />
          <h6 class="testVue">{{count0}}</h6>
        </div>
    </div>
</template>

<script>
import managedContent from './ManagedContent.vue';
import { mapState } from 'vuex';

export default {
    name: 'Fabius',
    components: { managedContent },
    data() {
      return {
        url: "http://blog.fabiuslela.com/fabiuss-introduction/"
      }
    },
    computed: mapState({
        count0(store) {
          return store.count0;
        }
      })
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
.pageBody{
  text-align: left;
}
.testVue{
  color: lightblue;
  font: 5em sans-serif;
}
</style>
