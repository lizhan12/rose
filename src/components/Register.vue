<template>
  <div class="register-box">
    <h2>会员注册</h2>
    <form method="post">
      <ul class="register-info">
        <li>
          国家和地区：<input type="select" name="country" v-model="country"  :value="country" required>
        </li>
        <li>
          <span class="ctr-code">+86</span><input type="text" name="account" placeholder="请输入手机号码/邮箱" v-model.trim="account" @input="checkAccount" :value="account" required>
        </li>
        <li>
          图片码：<input type="text" name="imgCode" placeholder="请输入图片码" v-model.trim="imgCode" :value="imgCode" @blur="checkCaptcha" required>
          <img :src="captcha" alt="图片码" class="img-code" title="图片验证码" @click="getCaptcha">
        </li>
        <li>
          短信码：<input type="text" name="msgCode"  placeholder="请输入验证码"  v-model.trim="msgCode" :value="msgCode" required>
          <span class="msg-code" @click="getMsgCode">{{time}}</span>
        </li>
        <li>
          密码：<input type="password" name="pwd" placeholder="请输入6-20位数字/字母密码" v-model="pwd" :value="pwd" required>
        </li>
      </ul>
      <p class="recall-code">没有收到短信验证码？请使用<a href="">语音验证码</a></p>
      <div @click="postData">
        <submit-btn :userData="userData">
          注 册
        </submit-btn>
      </div>
    </form>
    <p class="to-register">
      <router-link to="/login">已有账号登录</router-link>
    </p>
    <div class="countries">

    </div>

  </div>
</template>

<script>
  import submitBtn from './Submit-btn.vue'
  const during = 60;//信息码有效时间60s
  export default {
    name: 'register-box',
    data () {
      return {
        country: '中国',
        account: '',
        imgCode: '',
        msgCode: '',
        pwd: '',
        captcha:'http://localhost:8060/register/captcha/1',//'获取图片码',
        seconds: '',
      }
    },
    computed: {
      time: function(){
        return this.seconds || '获取验证码';
      },
      userData () {
        return this.country && this.account && this.pwd && this.imgCode && this.msgCode;
      },
    },
    components: {
      submitBtn
    },
    methods: {
      postData () {
        if(testAccount(this.account) === false){
          alert('账号格式不正确，请重新输入');
          return
        };
        if(testPwd(this.pwd) === false){
          alert('密码格式不正确，请重新输入');
          return
        };
        //通过ajax提交至后台查询
        const url = 'http://localhost:8060/register';
        const time = during - this.seconds; //获取信息码到发送信息码的时间
        const data = {country: this.country, account: this.account, pwd: this.pwd, imgCode: this.imgCode, msgCode: this.msgCode, time: time};
        this.$http.post(url, data, {emulateJSON: true}).then(res => {//请求成功时的回调
          //console.log(res.body);//response.body服务器发送的结果对象
          if(res.body.code === 1){
            alert("注册成功");
            setTimeout(function(){
              window.location = '/order'
            },3000)
          }else if(res.body.code === 2){
            alert(res.body.msg);
          }else if(res.body.code === 4){
            this.seconds ='';
            alert(res.body.msg);
          }else if(res.body.code === 6){
            this.seconds ='';
            alert(res.body.msg);
          }
        }, res => {//请求失败时的回调
          alert('服务器请求失败，请重新注册')
        });
      },
      getCaptcha () {
        let id = getRndInteger(100000, 999999);
        const url = `http://localhost:8060/register/captcha/${id}`;
        this.$http.get(url).then(res => {
          this.captcha = url;
        });
      },
      getMsgCode () {
        if(testAccount(this.account) === false){
          return
        };
        if(this.seconds){
          return
        }
        //获取手机验证码
        const url = 'http://localhost:8060/register/msgcode';
        const data = {tel: this.account};
        this.$http.post(url, data, {emulateJSON: true}).then(res => {
          let correctMsgCode = res.body;
          console.log('短信码 ： '+correctMsgCode);
          //倒计时60s
          this.seconds = Number(during);
//          const _this = this;
//          let timer = setInterval(function () {
//            _this.seconds --;
//            if(_this.seconds < 0){
//              _this.seconds = '';
//              _correctMsgCode ='';
//              clearInterval(timer);
//            }
//          },1000)
          //也可用箭头函数解决this的指向问题，箭头函数this指向引用的对象
          let timer = setInterval( () => {
            this.seconds --;
            if(this.seconds < 0){
              this.seconds = '';
              clearInterval(timer);
            }
          },1000)
        });


      },
      checkAccount () {
        const url = 'http://localhost:8060/register/check_account';
        const data = {account: this.account};
        this.$http.post(url, data, {emulateJSON: true}).then(res => {
          console.log(res)
          if(res.body.code === 5) {
            alert(res.body.msg);
            let input = document.querySelector("input[name='account']");
            input.focus();
            this.account = '';
          }
        })
      },
      checkCaptcha () {
        const url = 'http://localhost:8060/register/check_captcha';
        const data = {imgCode: this.imgCode};
        this.$http.post(url, data, {emulateJSON: true}).then(res => {
          if(res.body.code === 3) {
            if(this.imgCode){
              alert(res.body.msg);
            }
            let input = document.querySelector("input[name='imgCode']");
            input.focus();
            this.imgCode = '';
            this.getCaptcha();


          }
        })
      },

    }
  }
</script>

<style scoped lang='less'>
  .register-box {
    margin-top: 5rem;
    background: #f5f5f5;
    line-height: 5rem;
    padding: 0 1.5rem;
    input{
      font-size: 1.4rem;
      padding: 0 1rem;
      outline: none;
      border: none;
      width: 80%;
    }
    h2 {
      text-align: center;
      border-bottom: 1px solid #efefef;
      margin-bottom: 2rem;
    }
    ul.register-info {
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
    input[name=imgCode],input[name=msgCode]{
      width: 50%;
    }
    .img-code, .msg-code {
      vertical-align: middle;
      width: 8rem;
      height: 3.5rem;
      display: inline-block;
      border: none;
      border-radius: 3px;
      overflow: hidden;
      line-height: 3.5rem;
      /*padding: 0 .5rem;*/
      text-align: center;
    }
    .msg-code {
      font-size: 1.2rem;
      background: rgb(210, 210, 210);

    }
    }
    }
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

    }
    .recall-code {
      text-align: center;
    a{
      display: inline;
    }
    }
    .to-register {
      text-align: center;
    }

  }
</style>
