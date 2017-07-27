<template>
  <v-touch tag="div" class="content_box" @panstart.prevent="moveStart($event)" @panleft.prevent="moveLeft($event)" @panright.prevent="moveRight($event)" @panend = "finishMove()" :style="{transform: translate}" >
    <div class="content">
      <slot name="mainContent">
      </slot>
    </div>
    <div class="delete" @click="deleteList()">删除</div>
  </v-touch>
</template>

<script>

  const rex = /\.*translateX\((.*)px\)/;
  const delegation = 100;//删除按钮的宽
  let move = 0;
  let translateX;
  export default {
    name: 'list_box',
    props: ['index'],
    data () {
      return {
        translate: 'transformX(0px)'
      }
    },
    methods:{
      moveStart (){
        const divs = document.querySelectorAll('.content_box');//不能写实例外面，只能写里面
        for(let i=0;i<divs.length;i++){//开始滑动时，将所有的li的位移设置为0
            divs[i].style.transform = 'translateX(' + 0 + 'px)';
        }
      },
      moveRight (e) {//左右滑动，显示删除按钮
        translateX = parseFloat(rex.exec(this.translate)[1]);//读取已有位移
        console.log(translateX);
        if(translateX <= - delegation){
          translateX = - delegation
        }
        move = e.deltaX + translateX;
        if( move > 0 ){
          move = 0
        }
        this.translate = 'translateX(' + move + 'px)';

      },
      moveLeft (e) {
        move = e.deltaX;
        if(move <= -delegation){
          this.translate = 'translateX(' + (-delegation) + 'px)';
        }else {
          this.translate = 'translateX(' + move + 'px)';
        }

      },
      finishMove () {
        if(move>0){//右滑结束
          if(move>delegation/2){
            this.translate = 'translateX(' + 0 + 'px)';
          }else{
            this.translate = 'translateX(' + (-delegation) + 'px)';
          }
        }
        if(move<0){//左滑结束
          if(move<-delegation/2){
            this.translate = 'translateX(' + (-delegation) + 'px)';
          }else{
            this.translate = 'translateX(' + 0 + 'px)';
          }
        }
      },
      deleteList () {
        this.$emit('deleteItem',this.index);
        console.log('emit'+this.index);
      }
    }
  }
</script>

<style scoped lang='less'>


  .delete {
    width: 10rem;
    background: #c71f2c;
    line-height: 15rem;
    color: #fff;
    font-weight: bold;
    text-align: center;
    display: inline-block;

  }
  .content_box {
    white-space: nowrap;
    width: calc(100% + 10rem);
  }
  .content {
    display: inline-block;
    width: calc(100% - 10rem);
  }






</style>
