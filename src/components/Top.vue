<template>
  <div class="header">
    <slot name="nav-bar">
    </slot>
    <slot name="logo">
    </slot>
    <slot name="aside">
    </slot>
  </div>
</template>

<script>
////非父子组件间传值用 event bus 方法: 发送方bus.$emit,接收方bus.$on
//import bus from './bus.js';
export default {
  name: 'header',
  data () {
    return {
     count: 0
    }
  },
}

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="less">
.header {
  background: rgba(0,0,0,0.75);
  display: flex;
  justify-content: space-between;
  height: 5rem;
  text-align: center;
  flex:1;
}





</style>
