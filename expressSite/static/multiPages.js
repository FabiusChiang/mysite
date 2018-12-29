const Foo = {template:'<div>foo</div>'};
const Boo = {template:'<div>bar</div>'};

const routes = [
  {
    path: '/foo', 
    component: Foo
  },
  {
    path: '/boo', 
    component: Boo
  }
];

const router = new VueRouter({
  routes // short for `routes: routes`
})

const app = new Vue({
  router
}).$mount('#app');