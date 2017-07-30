<template>
  <div class="main">
    <p>亲爱的{{uname}}，欢迎登陆...</p>
  </div>
</template>

<script>
export default {
  name: 'main',
  data () {
    return {
    }
  },
  computed: {
    uname () {
    const name = sessionStorage.uname;
    if(name) {
      return name;
    }
  }
  }
}
</script>

<style scoped lang='less'>
  .main{
    margin-top: 5rem;
  p{
    text-align: center;
    line-height: 4rem;
    height: 4rem;
  }
  }
</style>
