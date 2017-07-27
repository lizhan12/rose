<template>
  <ul class="pay-footer">
    <li class="lt">
      <input type="checkbox" name="" id="selectAll" v-model="selAll" @click="sendAll()">
      <label for="selectAll" :class="{bgposition: selAll}">
        <b>
          全选
        </b>
      </label>
    </li>
    <li class="md">
      合计： ￥{{amount}}
    </li>
    <li class="rt">
      <router-link :to="toPay" :style="{background:bgcolor}">去结算({{parseInt(qty)}})</router-link>
    </li>
  </ul>
</template>

<script>
import top from './Top.vue'
import modal from './Modal.vue'
import bus from './bus.js';
export default {
  name: 'payFooter',
  props: ['allItems','selItems'],
  data () {
    return {
      selAll: false,
      bgcolor: '#ddd',
      bgposition: true,
    }
  },
  computed: {
    amount () {//总金额Array reduce API ，一定要写初始值，否则报错
      return this.selItems.reduce( function (p,v){
        return  p + v.price * v.count;

      },0);
    },
    qty () {
      return this.selItems.reduce( function (p,v){
        return p+v.count
      },0)
    },
    toPay () {
      const uid = sessionStorage.uid;
      if(uid) {
        return '/order'
      }else{
        return '/login'
      }
    }

  },
  watch: {
    'selItems': function() {//根据所选产品的变化，判断全选按钮是否被选中
        this.selItems.length === this.allItems.length ? this.selAll = true : this.selAll = false;
    },
    'qty' : function() {
      this.qty ? this.bgcolor = '#c71f2c' : this.bgcolor = '#ddd'
    }
 },
  methods: {
    sendAll () {
      //this.selAll = !!this.selAll;
      this.$emit('input',this.selAll);
    },
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="less">
  ul.pay-footer {
    display: flex;
    justify-content: space-between;
    font-size: 1.6rem;
    color: #fff;
    line-height: 4.5rem;
    font-weight: bold;
    label {
      margin-left: -3rem;
      position:absolute;
      top:12px;
      b{
        position: absolute;
        display: inline-block;
        top: -10px;
        left: 25px;
      }
    }

    > li {
      text-align: center;
      background: #414141;
      position: relative;
    }
    .lt {
      background-size: 2.5rem;
      width: 25%;
    }
    .md{
      width: 35%;
    }
    .rt {
      /*background: #c71f2c;*/
      width: 40%;
      a{
        color:#fff;
      }
    }
  }


</style>
