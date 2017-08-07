/**
 * Created by yupeiying on 6/23/17.
 */
const pool = require('./pool');
const ccap = require('ccap')(); //生成验证码
function checkImgCode(imgCode,req,res){
  if( imgCode !== req.session.imgCode) {
    var output = {
      code: 3,
      msg:'图片码不正确，请重新输入',
    }
    res.json(output);
  }else {
    req.session.imgCode = '';
  }
};
function checkMsgCode(msgCode,time,req){
  if(time > req.session.time) {
    var output = {
      code: 6,
      msg:'信息码已失效，请重新获取',
    };
    res.json(output);
    return;
  }else if(msgCode !== req.session.msgCode) {
    var output = {
      code: 4,
      msg:'信息码不正确，请重新输入',
    };
    res.json(output);
    return;
  }else {
    req.session.msgCode = '';
  }
};
function checkPwd(result,pwd,res) {
  if(pwd !== result[0].password){
    var output = {
      code: 7,
      msg: "密码错误，请重新输入",
    }
  }else{
    var output = {
      code: 1,
      msg: "登录成功",
      uid: result[0].uid,
      uname:result[0].username,
    }
  }
  res.json(output)
};
module.exports ={
  login: (req,res) => {
    var acct = req.body.account;
    var pwd = req.body.pwd;
    var ctry = req.body.country;
    console.log(req.body)
      pool.getConnection((err,conn)=>{
        conn.query('SELECT * FROM user WHERE country=? AND account=?',[ctry,acct],(err,result)=>{
          if(result.length>=1){
            checkPwd(result,pwd,res);
          }else {
            var output = {
              code: 2,
              msg: "登录失败，请重新登录",
            }
          }
          res.json(output);
          conn.release();
        })
      })
  },
  register: (req,res) => {
    const acct = req.body.account;
    const pwd = req.body.pwd;
    const ctry = req.body.country;
    const imgCode = req.body.imgCode;
    const msgCode =req.body.msgCode;
    const time = req.body.time;
    checkMsgCode(msgCode,time,req);
    pool.getConnection((err,conn) => {
      conn.query("INSERT INTO user VALUES (null,'',?,?,?,now())", [acct,pwd,ctry], (err,result) => {
        if(result.affectedRows >= 1){
          var output = {
            code: 1,
            msg:'注册成功',
            uid: result.uid
          }
        }else{
          var output = {
            code: 2,
            msg:'注册失败，请重新注册'
          }
        }
        res.json(output);
        conn.release();
      });
    })
  },
  captcha: (req,res) => {
    let ary = ccap.get();
    let txt = ary[0];
    let buf = ary[1];
    req.session.imgCode = txt;
    res.end(buf);
  },
  msgcode: (req,res) => {
      let ary = ccap.get();
      let txt = ary[0];
      req.session.msgCode = txt;
      req.session.time = 60;//信息码有效时间60s
      res.end(txt);
    },
  //查询数据库中账号是否已存在，如果存在就返回客户端信息：该账号已存在，请重新输入
  checkAccount: (req,res) => {
    const acct = req.body.account;
    
    pool.getConnection((err,conn) => {
      //查询数据库中账号是否已存在，如果存在就返回客户端信息：该账号已存在，请重新输入
      conn.query('SELECT * FROM user WHERE account = ?',[acct],(err,result) => {
        if (result.length >= 1) {
          var output = {
            code: 5,
            msg: '账号已存在，请重新输入',
          }
          res.json(output);
          conn.release();
        }
      })
    })
  },
  checkCaptcha: (req,res) => {
    const imgCode = req.body.imgCode;
    checkImgCode(imgCode,req,res);
  },

};


