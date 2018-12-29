var welcomeMsg = 'Hey, static file is loaded!<br/> wow!';

var welcomeBar = new Vue({
    el: '#welcomeBar',
    data: {
        message: welcomeMsg
    }
})

var app2 = new Vue({
    el: '#app-2',
    data: {
      message: 'You loaded this page on ' + new Date().toLocaleString()
    }
  })

  var app4 = new Vue({
    el: '#app-4',
    data: {
      todos: [
        { text: 'Learn JavaScript' },
        { text: 'Learn Vue' },
        { text: 'Build something awesome' }
      ]
    }
  })

  var app5 = new Vue({
    el: '#app-5',
    data: {
      message: 'Hello Vue.js!'
    },
    methods: {
      reverseMessage: function () {
        this.message = this.message.split('').reverse().join('')
      }
    }
  })

  var controlBar = new Vue({
    el: '#controlBar',
    data: {
        seen: true
    },
    methods: {
        toggle2: function () {
            console.log(this.seen);
            this.seen = !this.seen;
        }
    }
})