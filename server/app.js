const http = require('http');
const express = require('express');
const pathUtil = require('path');
const fs = require('fs');
// const qs = require('querystring');
const mysql = require ('mysql');
const pool = require ('./pool');
//const parseUrl = require('url').parse;
//const ejs = require('ejs');
const cors = require('cors');
const bodyParser = require("body-parser");
const session = require('express-session');
const cookieParser = require('cookie-parser');

//Here we are configuring express to use body-parser as middle-ware.
const app = express();
http.createServer(app).listen(8060);
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
//获取静态资源文件
app.use(express.static(pathUtil.join(__dirname, '../static')));
app.use(cookieParser());
app.use(session({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true,
    cookie: { maxAge: 60 * 1000 * 60 * 24 } //cookie保存24小时
}));
const issue2options = {
    origin: true,
    methods: ['GET','POST'],
    credentials: true,
    maxAge: 3600
};
//前后端端口不一样，跨域获取文件，对后端响应头作设置
//const setCors = function(req,res){
  // 获取请求头url,并解析
  // const parsed = parseUrl(req.header('referer') || '');
  // if (parsed.host) {
    // res.header('Access-Control-Allow-Credentials', 'true');
    // res.header('Access-Control-Allow-Headers', 'X-Requested-With,Content-Type');
    // res.header('Access-Control-Allow-Methods', 'GET,POST,OPTIONS,HEAD');
    // res.header('Access-Control-Allow-Origin', "*");
  //   res.header("Access-Control-Allow-Origin", "*");
  //   res.header("Access-Control-Allow-Headers", "X-Requested-With");
  //   res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
  //   res.header("X-Powered-By",' 3.2.1')
  //   res.header("Content-Type", "application/json;charset=utf-8");
  //   next();
  // }
//};
//引入自定义文件
const user = require('./user.js');
const product = require('./product.js');

app.options('*', cors(issue2options));
app.get('/index',cors(issue2options),product.main);
app.get('/detail/pid/:pid/cid/:cid',cors(issue2options),product.detail);
app.post('/login',cors(issue2options),user.login);
app.post('/register',cors(issue2options),user.register);
app.get('/register/captcha/:id',cors(issue2options),user.captcha);
app.post('/register/msgcode',cors(issue2options),user.msgcode);
app.post('/register/check_account',cors(issue2options),user.checkAccount);
app.post('/register/check_captcha',cors(issue2options),user.checkCaptcha);




app.post('/add_to_cart',cors(issue2options),product.addCart);
app.get('/cart',cors(issue2options), product.cart);
app.post('/cart/count',cors(issue2options),product.count);
app.post('/cart/delete',cors(issue2options),product.delete);
app.get('/index/cartItems',cors(issue2options),product.cartItems);















// const renderCache = new Map();
// function render(name, data) {
//   let fn = renderCache.get(name);
//   if (!fn) {
//     const path = pathUtil.join(__dirname, '../templates', name);
//     const tpl = fs.readFileSync(path, 'utf-8');
//     fn = ejs.compile(tpl);
//     renderCache.set(name, fn);
//   }
//   return fn(data);
// }










