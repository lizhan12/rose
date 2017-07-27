<template>
  <div class="hello">
    <!-- 轮播图 -->
    <div class="swiper-container" id="slider">
      <div class="swiper-wrapper">
        <div class="swiper-slide" v-for="str in listImg" :style="{ backgroundImage: 'url(' + str.url + ')' }"></div>
    </div>
      <div class="swiper-pagination swiper-pagination-black"></div>
    </div>
    <section id="section">
      <div class="part1">
        <h2 class="title"><img src="../../static/img/t9.jpg" alt=""></h2>
        <ul>
          <li v-for="product in graProducts">
            <router-link :to="`/detail/pid/${product.pid}/cid/${product.cid}`">
            <img  v-lazy="`../../static/img/${product.img}`" alt="产品图片">
            </router-link>
          </li>
        </ul>
      </div>
      <div class="part2">
        <h2 class="title"><img src="../../static/img/t10.jpg" alt=""></h2>
        <ul>
          <li v-for="product in loveProducts">
            <router-link  :to="`/detail/pid/${product.pid}/cid/${product.cid}`">
              <img  v-lazy="`../../static/img/${product.img}`" alt="产品图片">
            </router-link>
          </li>
        </ul>
      </div>
      <div class="part3">
        <h2 class="title"><img src="../../static/img/t8.jpg" alt=""></h2>
        <div>
          <a href="#" v-for="product in products3"><img   v-lazy="product.src" alt="产品图片"></a>
        </div>
      </div>
      <div class="part4">
        <h2 class="title"><img src="../../static/img/t2.jpg" alt=""></h2>
        <div class="content">
          <a href="#" v-for="product in products4">
            <img   v-lazy="product.src" alt="产品图片">
          </a>
        </div>
      </div>
      <div class="part5">
        <h2 class="title"><img  src="../../static/img/t7.jpg" alt=""></h2>
        <div class="content">
          <a href="#"><img   src="../../static/img/store.jpg" alt="专卖店图片"></a>
        </div>
      </div>
    </section>
    <!--<footer id="footer-nav">-->
      <!--<footer-nav>-->
        <!--<ul class="nav">-->
          <!--<li>-->
            <!--<router-link to="/index" class="home">主页</router-link>-->
          <!--</li>-->
          <!--<li>-->
            <!--<router-link to="/index" class="group">分类</router-link>-->
          <!--</li>-->
          <!--<li>-->
            <!--<router-link to="/index" class="activity">活动</router-link>-->
          <!--</li>-->
          <!--<li>-->
            <!--<router-link to="/cart" class="shoppingbag">购物袋</router-link>-->
          <!--</li>-->
          <!--<li>-->
            <!--<router-link to="/login" class="mine">我的</router-link>-->
          <!--</li>-->

        <!--</ul>-->
      <!--</footer-nav>-->
    <!--</footer>-->

  </div>
</template>

<script>
import footerNav from './Footer.vue';
import a from '../../static/img/slider1.jpg';
import b from '../../static/img/slider2.jpg';
import c from '../../static/img/slider3.jpg';
import d from '../../static/img/slider4.jpg';
import e from '../../static/img/slider5.jpg';
import f from '../../static/img/slider6.jpg';

export default {
  name: 'hello',
  data () {
    return {
      listImg: [
        {url: a},
        {url: b},
        {url: c},
        {url: d},
        {url: e},
        {url: f},
      ],
      graProducts: '',//毕业礼物产品
      loveProducts: '',//生日礼物产品
      products3: [
        {src: '../../static/img/d2.jpg'},
        {src: '../../static/img/d1.jpg'},
        {src: '../../static/img/d3.jpg'},
        {src: '../../static/img/d5.jpg'},
        {src: '../../static/img/d4.jpg'},
        {src: '../../static/img/d6.jpg'},
        {src: '../../static/img/d7.jpg'},
        {src: '../../static/img/d8.jpg'},
      ],
      products4: [
        {src: '../../static/img/b3.jpg'},
        {src: '../../static/img/b4.jpg'},
        {src: '../../static/img/b5.jpg'},
        {src: '../../static/img/b6.jpg'},
        {src: '../../static/img/b7.jpg'},
        {src: '../../static/img/b8.jpg'},
      ],
    }
  },
  // 组件挂载后设置，
  components: {
    footerNav,
  },
  mounted () {
    var swiper = new Swiper('.swiper-container', {
      pagination: '.swiper-pagination',
      paginationClickable: true,
      loop: true,
      speed: 600,
      autoplay: 4000,
      onTouchEnd: function () {
        swiper.startAutoplay()
      }
    });
  },
  // 组件创建完后获取数据，
  created:
    function() {
      console.log('indexmain')
      var url= "http://localhost:8060/index";
      this.$http.get(url).then(function(data){
        console.log(data.body)
        this.graProducts = data.body.slice(0,5);
        this.loveProducts = data.body.slice(5,10)
      });
    },

  methods: {


  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="less">
  #slider {
    &.swiper-container {
      width: 100%;
      height: 29rem;
      margin-top: 4.9rem;
    }
    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #ddd;
      display: flex;
      justify-content: center;
      align-items: center;
      background-size: 45rem;
      background-repeat: no-repeat;
      background-position: 50% 50%;
    }

    .swiper-pagination {
      bottom: 3rem;
      width: 100%;
    }
  }

  #section {
    img {
      width: 100%
    }
    h2 img {
      vertical-align: bottom;
    }
    .part4 .content {
      display: flex;
      flex-wrap:wrap;
      a {
        width: 50%;
      }
      img {
        /*width: 50%;*/
      }
    }
  }
  /*#footer-nav {*/
    /*a {*/
      /*text-indent: -9999px;*/
      /*background: url("/static/img/btn_menu.png") no-repeat;*/
      /*background-size: auto 100%;*/
      /*width: 22px;*/
      /*}*/
    /*.home {*/
      /*background-position: -27px 0 ;*/
    /*}*/
    /*.group {*/
      /*background-position: -54px 0 ;*/
    /*}*/
    /*.activity {*/
      /*background-position: -108px 0 ;*/
    /*}*/
    /*.shoppingbag {*/
      /*background-position: -153px 0 ;*/
      /*width: 35px*/
    /*}*/
    /*.mine {*/
      /*background-position: -290px 0 ;*/
    /*}*/

  /*}*/







</style>
