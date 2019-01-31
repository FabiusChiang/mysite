<template>
    <div class="col-sm-8">
        <h2>Lela introduction</h2>
        <h5>Start, Jan 1, 2019</h5>
        <div class="fakeimg">Fake Image</div>
        <div class="pageBody">
          <!-- <managedContent v-bind:dataSource="url" /> -->
          <managedContent dataSource="http://blog.fabiuslela.com/lelas-introduction/" />
        </div>
    </div>
</template>

<script>
import managedContent from './ManagedContent.vue';

export default {
    name: 'Lela',
    components: { managedContent },
    data() {
      return {
        url: "http://blog.fabiuslela.com/lelas-introduction/"
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
.pageBody{
  text-align: left;
}
</style>
