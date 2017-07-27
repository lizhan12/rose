<template>
  <div class="mycart">
    <h2 @click="check">购物车</h2>
    <div class="mylist">
      <ul>
        <v-touch tag="li" v-for="(item,index) in items" @panleft="showDelete(index,$event)" @panright="hideDelete(index,$event)" @panend = "handleDelete">
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
          <div class="delete">删除</div>
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
  import bus from './bus.js';
  bus.$on('selectedItem',function(items) {
    console.log(items);
    return itemsList = items;
  });
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
        transform: 'translateX(0)',
        move: 0
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
      payFooter
    }
    ,
    created: function () {
      const url = 'http://localhost:8060/cart';
      this.$http.get(url,{emulateJSON: true}).then(res => {
        this.items = res.body;
      },res => {});
    },
    methods: {
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
      showDelete (i,e) {
        e.preventDefault();
          const w = 100;//'删除'键宽度
          this.move = e.deltaX
          console.log(this.move);
          if(-this.move >= w){//当滑动的距离大于删除按钮的宽度时，停止位移
              this.move = -w;
          }
          this.transform = 'translateX('+this.move+'px)'
      },
      hideDelete (i,e) {
        e.preventDefault();
        const w = 100;//'删除'键宽度
        if(-this.move>0) {//如果已经向左滑动过
          let move = e.deltaX;//获取触点距离上一次事件移动的距离对象，对象包含 x 和 y 属性
          if( move >= w){//当滑动的距离大于删除按钮的宽度时，停止位移
              move = w;
          }
          this.move = -(-this.move-move);
          this.transform = 'translateX('+(this.move)+'px)'
        }else{
          this.move = 0;
          this.transform = 'translateX(0)'
        }
      },
      handleDelete (i,e) {
        const w = 100;//'删除'键宽度
        const move = Math.abs(this.move);
          if( move <  w/2 ){
            this.move = 0;
          }else{
            this.move = -w;
          }
          this.transform = 'translateX('+(this.move)+'px)'
      },
      check () {
          console.log(this.move);
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
  .mylist{
    background: #ddd;
    width: 100%;
    overflow: hidden;
    li {
      display: flex;
      /*border: 1px solid #e1e1e1;*/
      /*background: #fff;*/
      /*margin-bottom: 1.5%;*/
      /*align-items: center;*/
      /*flex-wrap: nowrap;*/
      /*white-space: nowrap;*/
      width:125%;
      overflow: hidden;
      .main{
        display: flex;
        /*border: 1px solid #e1e1e1;*/
        background: #fff;
        margin-bottom: 1.5%;
        align-items: center;
        /*overflow: hidden;*/
        width: 100%;
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
