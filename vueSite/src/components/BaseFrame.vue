<template>
  <div class="baseFrame">
    <div class="jumbotron text-center" style="margin-bottom:0">
      <h1>My First Bootstrap 4 Page</h1>
      <p>Resize this responsive page to see the effect!</p> 
    </div>
    <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
      <a class="navbar-brand" href="#">==></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="collapsibleNavbar">
        <ul class="navbar-nav">
          <li class="nav-item">
            <router-link to="/" class="nav-link">Home</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/Fabius" class="nav-link">Fabius</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/Lela" class="nav-link">Lela</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/AboutThis" class="nav-link">About this site</router-link>
          </li>
        </ul>
      </div>
    </nav>

    <div class="container" style="margin-top:30px">
      <div class="row">
        <LeftPart />
        <router-view/>
      </div>
    </div>


    <div class="jumbotron text-center" style="margin-bottom:0">
      <p>Footer</p>
    </div>

  </div>
</template>

<script>
import LeftPart from './LeftPart'


export default {
  name: 'BaseFrame',
  components: {
    LeftPart
  },
  data () {
    return {
      msg: 'Welcome to Your Vue.js App'
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
