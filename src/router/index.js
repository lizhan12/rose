import Vue from 'vue'
import Router from 'vue-router'
import Index from '../components/home.vue'
import Detail from '@/components/Detail.vue'
import Cart from '@/components/Cart.vue'
import Login from '@/components/Login.vue'
import Register from '@/components/Register.vue'
import Order from '@/components/Order.vue'
import MyCenter from '@/components/Personal_center.vue'

Vue.use(Router);
export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'index',
      component: Index,
    },
    {
      path: '/index',
      name: 'index',
      component: Index,
    },
    {
      path: '/group',
      name: 'group',
      component: Index,
    },
    {
      path: '/activity',
      name: 'activity',
      component: Index,
    },
    {
      path: '/detail/pid/:pid/cid/:cid',
      name: 'detail',
      component: Detail
    },
    {
      path: '/cart',
      name: 'cart',
      component: Cart
    },
    {
      path:'/login',
      name:'login',
      component:Login
    },
    {
      path:'/register',
      name:'register',
      component: Register
    },
    {
      path:'/order',
      name:'order',
      component: Order
    },
    {
      path:'/personal_center',
      name:'myCenter',
      component: MyCenter
    }
  ],
  scrollBehavior (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { x: 0, y: 0 }
    }
  }
})
