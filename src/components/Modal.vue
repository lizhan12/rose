<template>
  <div class="modal-outer">
    <div class="modal-inner">
      <div class="tip">
        <p>成功加入购物车</p>
      </div>
      <div class="btn">
        <a @click="closeModal" class="btn-lf">继续购物</a>
        <router-link to="/cart" class="btn-rt">去结算</router-link>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'modal-outer',
    data () {
      return {
          //msg: ''

      }
    },
    methods: {
      closeModal () {
        let bool = false;
        this.$emit('input',bool);
      }
    }
  }
</script>

<style scoped lang='less'>
  @base: #444;
  body{
    line-height: 1.2;
  }
.modal-outer {
  background: rgba(0, 0, 0, 0.3);
  z-index: 100;
  width:100%;
  height:100%;
}
.modal-inner {
  position: absolute;
  width: 80%;
  height: 13rem;
  margin:auto;
  top:0;
  right:0;
  bottom:0;
  left: 0;
  border-radius: 3px;
  overflow: hidden;
  .tip{
    position: relative;
    height: 9rem;
    background: #fff;
    color: @base;
    overflow:hidden;
    p{
      position: absolute;
      width: 90%;
      margin:auto;
      top:50%;
      left: 50%;
      transform:translate(-50%,-50%);
    }
  }
  .btn {
    display: flex;
    width: 100%;
    height: 4rem;
    line-height: 4rem;
    .btn-lf {
      background: #aaa;
      width: 50%;
    }
    .btn-rt {
      background: #c71f2c;
      width: 50%;
      color:#fff;
    }
  }



}




</style>
