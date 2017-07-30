<template>
    <div class="login-box">
      <h2>会员登录</h2>
      <form method="post">
        <ul class="login-info">
          <li>
            国家和地区：<input type="select" name="country" value="country" ref="country" v-model.trim="country">
          </li>
          <li>
            <span class="ctr-code">+86</span><input type="text" name="account" placeholder="请输入手机号码/邮箱" ref="account" v-model.trim="account" :value="account">
          </li>
          <li>
            密码：<input type="password" name="pwd" placeholder="请输入密码" ref="pwd" v-model.trim="pwd" :value="pwd">
          </li>
        </ul>
        <p class="recall-pwd"><a href="">找回密码</a></p>
        <!--<button type="button" @click="postData" :style="{background: btnBg}" :disabled="isButtonDisabled" @touchstart="changeBtnColor" @touchend="resumeBtnColor">登录</button>-->
        <div @click="postData">
         <submit-btn :userData="userData"/>
        </div>
      </form>
      <p class="to-register">
        <router-link to="/register">快速注册</router-link>
      </p>
      <div class="countries">

      </div>

    </div>
</template>

<script>
  import submitBtn from './Submit-btn.vue'
  export default {
    name: 'app',
    data () {
      return {
        country: '中国',
        account: '',
        pwd:'',
      }
    },
    computed: {
      userData () {
        return this.country && this.account && this.pwd;
      },
    },
    components: {
     submitBtn
    },
    methods: {
      postData () {
      //验证账号和密码格式
        if(testAccount(this.account) === false || testPwd(this.pwd) === false ){
            return
        };
        //通过ajax提交至后台查询
        var url = 'http://localhost:8060/login';
        var data = {account: this.account, pwd: this.pwd, country: this.country};
        this.$http.post(url, data, {emulateJSON: true}).then(res => {//请求成功时的回调
          //alert('服务器请求成功');
          //console.log(res.body);//response.body服务器发送的结果对象
          //将uid,uname保存到sessionStorage
          sessionStorage['uid'] = res.body.uid;
          sessionStorage['uname'] = res.body.uname;
          if(res.body.code === 7){
            alert(res.body.msg);
            this.pwd = '' ;
            let input = document.querySelector("input[name='pwd']");
            input.focus();
          }else if(res.body.code === 1){
            setTimeout(function(){
              window.location = '/order'
            },3000)
          }else if(res.body.code === 2){
            alert(res.body.msg);
          }
        }, res => {//请求失败时的回调
          alert('服务器请求失败，请重新登录')
        });
      },
    },
  }
</script>

<style scoped lang='less'>
  .login-box {
    margin-top: 5rem;
    background: #f5f5f5;
    line-height: 5rem;
    padding: 0 1.5rem;
    input{
      font-size: 1.4rem;
      padding: 0 1rem;
      outline: none;
      border: none;
    }
    h2 {
      text-align: center;
      border-bottom: 1px solid #efefef;
      margin-bottom: 2rem;
    }
    ul.login-info {
      background: #fff;
      padding: 0 2em;
      overflow: hidden;
      li {
        border-bottom: 1px solid #efefef;
        height: 5rem;
        white-space: nowrap;
        .ctr-code {
          border-right: 1px solid #efefef;
          display: inline-block;
          padding: 0 1rem;
        }

      }
    }
  .recall-pwd {
    text-align: right;
    a{
      display: inline;
    }
  }
  .to-register {
    text-align: center;
  }

  }

</style>
