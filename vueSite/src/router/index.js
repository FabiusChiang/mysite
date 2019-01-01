import Vue from 'vue'
import Router from 'vue-router'
import BaseFrame from '@/components/BaseFrame'
import Home from '@/components/Home'
import FabiusIntro from '@/components/FabiusIntro'
import LelaIntro from '@/components/LelaIntro'
import Post from '@/components/Post'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'BaseFrame',
      component: BaseFrame,
      children: [
        {
          path: '',
          component: Home
        },
        {
          path: 'Fabius',
          component: FabiusIntro
        },
        {
          path: 'Lela',
          component: LelaIntro
        }
      ]
    },
    {
      path: '/posts/:postId',
      name: 'Post',
      component: Post
    }
  ]
})
