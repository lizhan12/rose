<template>
  <div id="app">
    <header id="header">
      <top>
        <div slot="nav-bar" class="top-icon">
          <!--<div class="icon-bar">-->
            <!--<span></span>-->
            <!--<span></span>-->
          <!--</div>-->
          <b class="nav-back" v-if="navBack" @click="getBack"></b>
        </div>
        <div slot="logo" class="main-logo">
          <router-link to="/index">
            <img src="/static/img/nav_logo.png" alt="头部logo">
          </router-link>
        </div>
        <div slot="aside" class="user">
          <router-link to="/cart" class="cart-link">
            <img class="cart" src="/static/img/nav_car.png" alt="购物车">
            <span class="count" v-show="count">{{count}}</span>
          </router-link>
        </div>
      </top>
    </header>
    <!--<img src="./assets/logo.png">-->
    <router-view></router-view>
    <footer id="footer-nav" v-if="showNav">
      <footer-nav>
        <ul class="nav">
          <li>
            <router-link to="/index" class="home" :style="{backgroundPosition: homeBgp}">主页</router-link>
          </li>
          <li>
            <router-link to="/group" class="group" :style="{backgroundPosition: groupBgp}">分类</router-link>
          </li>
          <li>
            <router-link to="/activity" class="activity" :style="{backgroundPosition: actBgp}">活动</router-link>
          </li>
          <li>
            <router-link to="/cart" class="shoppingCart" :style="{backgroundPosition: cartBgp}">购物袋</router-link>
          </li>
          <li>
            <router-link :to="personalCenter" class="personal" :style="{backgroundPosition: personalBgp}">我的</router-link>
          </li>
        </ul>
      </footer-nav>
    </footer>
  </div>
</template>

<script>
import top from './components/Top.vue';
import footerNav from './components/Footer.vue';
//非父子组件间传值用 event bus 方法: 发送方bus.$emit,接收方bus.$on
import bus from './components/bus.js';
//保存首次进入时候的地址
const init_href = location.href;
export default {
  name: 'app',
  data () {
    return {
      homeBgp: '-5px 0',
      groupBgp: '-54px 0',
      actBgp: '-108px 0',
      cartBgp: '-153px 0',
      personalBgp: '-290px 0',
      showNav: true,
      cartItems: '',
      count: 0,
      navBack: false,

    }
  },
  computed : {
     personalCenter () {
       const uid = sessionStorage.uid;
       if(uid){
         return '/personal_center'
       }else{
         return '/login'
       }
     }
  },
  components: {
    top,
    footerNav
  },
  watch: {
    //路由变化，脚步点亮导航变化
    '$route' : 'changeFooterNav',
  },
  created: function () {
    bus.$on('addCount', function (count) {
      this.count += count;
    }.bind(this))
  },
  mounted: function () {
    switch (this.$route.name) {
      case 'index':
        this.homeBgp = '-27px 0';

        break;
      case 'group':
        this.groupBgp = '-76px 0';
        break;
      case 'activity':
        this.actBgp = '-130px 0';
        break;
      case 'cart':
        this.cartBgp = '-185px 0';
        this.showNav = false;
        break;
      case 'myCenter':
        this.personalBgp = '-312px 0';
        break;
      case 'detail':
        this.showNav = false;
    };
    //记录
    this.mark = true;

  },
  methods: {
    changeFooterNav () {
      const rn = this.$route.name;
      if(rn === 'index'){
        this.homeBgp = '-27px 0';
        this.showNav = true;
      }else{
        this.homeBgp = '-5px 0';
      }
      if(rn === 'group'){
        this.groupBgp = '-76px 0';
        this.showNav = true;
      }else{
        this.groupBgp = '-54px 0';
      }
      if(rn === 'activity'){
        this.actBgp = '-130px 0';
        this.showNav = true;
      }else{
        this.actBgp = '-108px 0';
      }
      if(rn ==='cart'){
        this.showNav = false;
        this.count = 0;
        this.cartBgp = '-185px 0';
      }else{
        this.cartBgp =  '-153px 0';
      }
      if(rn === 'myCenter'){
        this.personalBgp = '-312px 0';
      }else{
        this.personalBgp = '-290px 0';
      }
      if(rn === 'detail'){
        this.showNav = false;
      }
      //如果购物车有产品，购物袋加红点显示
      const url = 'http://localhost:8060/index/cartItems';
      this.$http.get(url).then(res=>{
        if(res.body.data == true){
          this.cartBgp = '-220px 0';
        }
      })
      //显示/掩藏后退按钮
      this.navBack = true;
    },
    getBack () {
      window.history.go(-1);
    },
  }
}
</script>

<style lang="less">
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
#header {
  position: fixed;
  width: 100%;
  z-index:99;
  top:0
}
#footer-nav {
  a {
    text-indent: -9999px;
    background: url("/static/img/btn_menu.png") no-repeat;
    background-size: auto 100%;
    width: 22px;
  }
  .shoppingCart {
    width: 35px
  }
}
#header {
  .top-icon{
    width: 20%;
  }
  .main-logo{
    width: 60%;
  }
  .user {
    width: 20%;
    display: flex;
    justify-content: flex-end;
    align-content: center;
    margin-right: 2rem;
  }
  .cart-link {
    white-space: nowrap;
  }
  .count {
    display: inline-block;
    line-height: 5rem;
    color: #fff;
    font-weight: bold;
    margin-left: -.3rem;
  }
  .main-logo img {
    height: 3rem;
    margin-top: 1rem;
    vertical-align: top;
  }
  .user img {
    height: 2.5rem;
    margin-top: 1rem;
    vertical-align: top;
  }
  .user > img:first-child {
    margin-right: 1rem;
  }
  .top-icon {
    .icon-bar {
      > span:first-child{
          margin-top: 1.8rem;
          margin-bottom: 1rem;
        }
      > span {
      display: block;
      width: 2rem;
      height: 0.2rem;
      background: #fff;
      margin-left: 2rem;
      }
    }
     .nav-back{
       background: url(/static/img/nav_back.png) no-repeat;
       background-size: contain ;
       width: 20px;
       height: 20px;
       display: inline-block;
       margin-top: 15px;
     }
  }
}
</style>
