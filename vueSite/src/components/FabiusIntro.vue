<template>
    <div class="col-sm-8">
        <h2>Fabius introduction</h2>
        <h5>Title1 description, Dec 7, 2017</h5>
        <div class="fakeimg">Fake Image</div>
        <p>Hi I am Fabius</p>
        <div>
          <div class="entry-content">
            <p>Hello, I am Fabius. I like cooking and coding.</p>
            <p>I write some blogs sometimes, you’re very welcome to visit my blog at http://blog.fabiuslela.com. In order to avoid spam comment, I enabled the review of comment. So your comment won’t be displayed until I see it. You know there are a lot of robots trying to spread virus through the comments in WordPress.</p>
          </div>
        </div>
        <iframe src="http://blog.fabiuslela.com/fabiuss-introduction/"/>
    </div>
</template>

<script>
export default {
    name: 'Home'
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
.entry-content {
  text-align: left;
}
</style>
