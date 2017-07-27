<template>
  <button class="btn" type="button" :style="{background: btnBg}" :disabled="isButtonDisabled" @touchstart="changeBtnColor" @touchend="resumeBtnColor">
    <slot>登 录</slot>
  </button>
</template>

<script>
  export default {
    name: 'btn',
    props: ['userData'],
    data () {
      return {
        btnBg: "rgb(225, 225, 225)",
        isButtonDisabled: 'disabled',
      }
    },
    watch: {
      'userData' : function () {
        if (this.userData) {
          this.btnBg = "green";
          this.isButtonDisabled = null;
        } else {
          this.btnBg = "rgb(225, 225, 225)";
          this.isButtonDisabled = 'disabled'
        }
      }
    },
    methods : {
      changeBtnColor () {
        if(this.userData){
          this.btnBg ='#015801';
        }
      },
      resumeBtnColor () {
        if(this.userData){
          this.btnBg ='green';
        }
      }

    },

  }
</script>

<style scoped lang='less'>
  button {
    height: 5rem;
    text-align: center;
    width: 100%;
    background: rgb(225, 225, 225);
    color:#fff;
    font-size: 1.8rem;
    font-weight: bold;
    border: none;
    border-radius: 3px;
    outline: none;
  }



</style>