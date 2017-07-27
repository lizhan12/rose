<template>
  <div class="mycart" :style="{minHeight:minH}">
    <h2>购物车</h2>
    <div class="list_box">
      <p v-if="loading">
        正在加载，请稍后...
      </p>
      <p v-if=" update === true && items.length === 0">
        您还没有选购任何商品，快去选购吧
        <router-link to="/index" class="index_page">首页</router-link>
      </p>
      <ul class="list">
        <v-touch tag="li" v-for="(item,index) in items" @panstart="moveStart" @panmove="move(index,$event)" @panend = "finishMove(index)">
          <slot name="mainContent">
            <div class="main">
              <div class="checkbox">
                <input type="checkbox" v-model="item.selected" :id="`label${index}`">
                <label :for="`label${index}`" :class="{bgposition: item.selected}"></label>
              </div>
              <router-link :to="`/detail/pid/${item.pid}/cid/${item.cid}`" class="img-link">
                <img :src="`/static/img/product/${item.simg}`" alt="">
              </router-link>
              <div class="desc">
                <b>{{item.name}}</b>
                <br> {{item.series}}  {{item.qty + item.size}}
                <div class="qty">
                  <span @click="reduce(item.count,index)"> - </span>
                  <input type="text" :value="item.count" class="count" @change="input(item.count,index)" v-model.lazy.number="item.count">
                  <span @click="add(item.count,index)"> + </span>
                </div>
              </div>
              <span class="price">￥ {{item.price}}</span>
            </div>
          </slot>
          <slot name="rightBtn">
            <div class="delete" @click="deleteList(index,item.pid,item.cid)">删除</div>
          </slot>
        </v-touch>
      </ul>
    </div>
    <div class="footer">
      <pay-footer @input="getAll" :allItems="items" :selItems="selItems" ></pay-footer>
    </div>
  </div>
</template>

<script>
  import payFooter from './Pay_footer.vue'
//  import list from './List.vue'
  import bus from './bus.js';
  bus.$on('selectedItem',function(items) {
    return itemsList = items;
  });

  const rex = /\.*translateX\((.*)px\)/;
  const delegation = 100;//删除按钮的宽
  let move = 0;
  let translateX;

  function postData(count,i) {
    const url = 'http://localhost:8060/cart/count';
    this.items[i].count = count;
    const cartItems = JSON.stringify(this.items);
    const data ={cartItems};
    this.$http.post(url,data,{emulateJSON: true}).then(res => {
      this.items = res.body;
    })

  }



  export default {
    name: 'mycart',
    data () {
      return {
        items: [],
        inputCount: '',
        minH: (screen.height-50-45)+'px',//50和40
        loading: false,
        update: false,
      }
    },
    computed: {
      selItems: function () {
        return this.items.filter((v) => {
          return v.selected === true
        })
      },
    },
    components: {
//      list,
      payFooter
    }
    ,
    created: function () {
      //正在加载中,数据未更新
      this.loading = true;
      this.update = false;
      const url = 'http://localhost:8060/cart';
      this.$http.get(url,{emulateJSON: true}).then(res => {
        //加载完成，数据已更新
        this.loading = false;
        this.items = res.body;
        this.update = true;
      })
    },
    mounted: function () {
      //初始化所有li的位移为0
      const lis = document.querySelectorAll('.list li');
      for(let i=0;i<lis.length;i++) {
          console.log(1);
          lis[i].style.transform = 'translateX(' + 0 + 'px)';
      }
    },

    methods:{
      reduce (count,i) {
        count--;
        if(count <= 0 ) {
          count = 0;
        }
        postData.call(this,count,i);
      },
      add (count,i) {
        count++;
        postData.call(this,count,i);
      },
      input (count,i) {
        postData.call(this,count,i);
      },
      getAll (v) {
        if(v){
          this.selAll = true;
          this.items.forEach(function(v) {
              v.selected = true;
          })
          //请求服务器
        }else{
          this.selAll = false;
          this.items.forEach(function(v) {
              v.selected = false;
          })
          //请求服务器
        }
      },

      moveStart (){
        const lis = document.querySelectorAll('.list li');//不能写实例外面，只能写里面
        for(let i=0;i<lis.length;i++){//开始滑动时，将所有的li的位移设置为0
            lis[i].style.transform = 'translateX(' + 0 + 'px)';
        }
      },
      move (i,e) {//左右滑动，显示删除按钮
        const lis = document.querySelectorAll('.list li');
        translateX = parseFloat(rex.exec(lis[i].style.transform)[1]);//读取已有位移
        if( translateX >= -delegation && translateX <= 0 ){
          if(!(translateX == 0 && e.deltaX>0) && !(translateX == -delegation && e.deltaX<0)){
              move = translateX + e.deltaX;
              if(move>0) move=0;
              if(move<-delegation) move=-delegation;
              lis[i].style.transform = 'translateX(' + move + 'px)';
          }
        }
      },
//      分别设置左右滑动，不是很平滑，需要再检查
//      moveLeft (i,e) {
//        const lis = document.querySelectorAll('.list li');
//        translateX = parseFloat(rex.exec(lis[i].style.transform)[1]);//读取已有位移
//        move = translateX + e.deltaX;//新位移 = 已有位移 + x轴移动距离
////        console.log(move);
//        if(move<-delegation) {
//          move = -delegation;
//        }
//        lis[i].style.transform = 'translateX(' + move + 'px)';
//      },
//      moveRight (i,e) {
//        const lis = document.querySelectorAll('.list li');
//        translateX = parseFloat(rex.exec(lis[i].style.transform)[1]);
//        move = translateX + e.deltaX;
//        console.log(move);
//        if(move>0) {
//          move = 0;
//        }
//        lis[i].style.transform = 'translateX(' + move + 'px)';
//      },
      finishMove (i) {
        const lis = document.querySelectorAll('.list li');
        if(move>0){//右滑结束
          if(move>delegation/2){
              lis[i].style.transform = 'translateX(' + 0 + 'px)';
          }else{
              lis[i].style.transform = 'translateX(' + (-delegation) + 'px)';
          }
        }
        if(move<0){//左滑结束
          if(move<-delegation/2){
              lis[i].style.transform = 'translateX(' + (-delegation) + 'px)';
          }else{
              lis[i].style.transform = 'translateX(' + 0 + 'px)';
          }
        }
      },
      deleteList (i) {
        this.items.splice(i,1);
        const url = 'http://localhost:8060/cart/delete';
        const cartItems = JSON.stringify(this.items);
        const data ={cartItems};
        this.$http.post(url,data,{emulateJSON: true}).then(res => {
            this.items = res.body;
        })
      }
    }
  }
</script>

<style scoped lang='less'>
  h2{
    margin-top: 5rem;
    text-align: center;
    height: 5rem;
    line-height: 5rem;
    border-bottom: 1px solid #e1e1e1;
    background: #ddd;
  }
  .mycart{
    background: #ddd;
    margin-bottom: 45px;
  }

  .list_box{
    background: #ddd;
    width: 100%;
    overflow: hidden;
    >p{
    text-align: center;
    line-height: 1.5;
    .index_page{
      text-decoration: underline;

    }
     }
    li {
      display: flex;
      /*transform: translate(0);*/
      /*border: 1px solid #e1e1e1;*/
      /*background: #fff;*/
      /*margin-bottom: 1.5%;*/
      /*align-items: center;*/
      /*flex-wrap: nowrap;*/
      /*white-space: nowrap;*/
      width: 126%;/*数字有点问题*/
      /*width: calc(100% + 10rem);!*css3的内容，如果设备不支持会用上面的宽度*!*/
      overflow: hidden;
      .main{
        display: flex;
        /*border: 1px solid #e1e1e1;*/
        background: #fff;
        margin-bottom: 1.5%;
        align-items: center;
        /*overflow: hidden;*/
        width: 100%;
        /*width:calc(100% - 10rem);!*css3的内容，如果设备不支持会用上面的宽度*!*/
      }
      .checkbox{
        width: 10%;
        text-align: center;
        margin-right: 1rem;
      }
      .img-link{
        width: 30%;
      }
      img{
        width:10rem;
        padding: .5rem;
        border: 1px solid #aaa;
        vertical-align: middle;
        margin: 2rem 0;
      }
      .desc{
        width: 30%;
        margin: 0 2rem;
      }
      .qty{
        /*font-size: 0;*/
        margin-top: 2rem;
        display:flex;
        span{
          display: inline-block;
          border: 1px solid #aaa;
          width: 2.4rem;
          height: 2.4rem;
          line-height: 2.4rem;
          text-align: center;
          font-size: 2rem;
        }
        .count{
          width: 3rem;
          border: 1px solid #aaa;
          outline: none;
          border-right: none;
          border-left: none;
          text-align: center;
          font-size: 1.4rem;
        }
      }
      .price {
        font-weight: bold;
        font-size: 1.6rem;
        white-space: nowrap;
        width: 30%;
      }
    }
    .delete {
      width:10rem;
      background: #c71f2c;
      line-height: 14rem;
      height:14rem;
      color: #fff;
      font-weight: bold;
      text-align: center;
      display: inline-block;

    }
  }
  .footer{
    position: fixed;
    width: 100%;
    bottom: 0;
  }

</style>
