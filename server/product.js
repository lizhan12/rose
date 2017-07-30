/**
 * Created by yupeiying on 6/23/17.
 */
const pool = require('./pool');
const await = require('await')
function getConn() {
    return new Promise((resolve, reject) => {
        pool.getConnection((e, conn) => {
            e ? reject(e) : resolve(conn);
        });
    });
}
function getData(req, conn) {
    const pid = req.params.pid;
    const cid = req.params.cid;
    const sql1 = `SELECT * FROM ro_color WHERE pid=? And cid=? `;
    const sql2 = `SELECT * FROM rec_item`;
    let data = [];
    data[0] = execQuery(conn, sql1, [pid, cid]);
    data[1] = execQuery(conn, sql2);
    return data;
}
function execQuery(conn, sql, args = []) {// args = []表示参数为数组
  return new Promise((resolve, reject) => {
    conn.query(sql, args, (e, result) => {
      e ? reject(e) : resolve(result);
    });
  });
}
function getColorImg(conn, pid, cid) {
  return execQuery(conn, 'SELECT current_col_img FROM ro_color WHERE pid=? AND cid=?', [pid, cid]);
}
function getProduct(conn, pid) {
  return  execQuery(conn, 'SELECT * FROM ro_item WHERE pid=?', [pid]);
}
function getMain(conn){
  return  execQuery(conn,'SELECT * FROM ro_item')
}
module.exports ={
  main: (req, res)=>{
    getConn().then((conn)=>{
      execQuery(conn,'SELECT * FROM ro_item').then((result)=>{
        res.json(result);
        conn.release();
      })
    })
    //const conn =  getConn()
    //const roseItems = getMain(conn);
    //console.log(roseItems)

    //res.json(roseItems); //把指定的对象转换为JSON字符串，并输出给客户端 = JSON.stringify + write + setHeader
    //conn.release();
    // pool.getConnection((err, conn)=>{
    //   conn.query('SELECT * FROM ro_item',(err, result)=>{
    //     const roseItems = result;
    //     //setCors(req,res);
    //     res.json(roseItems); //把指定的对象转换为JSON字符串，并输出给客户端 = JSON.stringify + write + setHeader
    //     conn.release();
    //   })
    // })
  },
  detail:  (req, res)=> {
    // const conn = getConn();
    // getData(req, conn).then(data => {
    //   res.json(data);
    //   conn.release();
    // });
    getConn().then(conn=>{
      const pid = req.params.pid;
      const cid = req.params.cid;
      const sql1 = `SELECT * FROM ro_color WHERE pid=? And cid=? `;
      const sql2 = `SELECT * FROM rec_item`;
      let data = [];
        execQuery(conn, sql1, [pid, cid]).then(result=>{
          data[0]=result;
          execQuery(conn, sql2).then(result=>{
            data[1]=result;
            res.json(data);
            conn.release();
            return data;
          })
        })
       
      
      
      
    })   
    
  },
  addCart: (req,res) => {
    const items = req.session.items || [];
    const pid = req.body.pid;
    const cid = req.body.cid;
    const count = Number(req.body.count) || 1;
    const item = items.find(item => item.pid === pid && item.cid === cid);
    if (item) {
      item.count = item.count + count;
    } else {
      items.push({ pid, cid, count });
    }
    req.session.items = items;
    res.json({ success: true });
  },
  cart:  (req,res) => {
    const items = req.session.items || [];
    const conn =  getConn();
    // const conn = getConn().then(conn=>{
    //   return conn
    // })
    let itemsList = [];
    let progress=0;
    for (let i = 0; i < items.length; i++) {
      const item = items[i];
      //const color =  getColorImg(getConn(), item.pid, item.cid); 
      //const simg = color[0].current_col_img;
     
      //   pool.getConnection((err,conn)=>{
      //   conn.query('SELECT current_col_img FROM ro_color WHERE pid=? AND cid=?',[item.pid, item.cid],(err,result)=>{
      //     itemsList.push(result[0].current_col_img);
      //     progress++
      //     if(progress==items.length){
      //       console.log(itemsList);
      //     }
          
      //   }
      //   );

      // })
  
      conn.then(conn=>{
        execQuery(conn, 'SELECT current_col_img FROM ro_color WHERE pid=? AND cid=?', [item.pid, item.cid]).then(result=>{
          return result 
          //const color=result;
         // const simg = color[0].current_col_img;
          //console.log(simg+'cart');
          //conn.release();
        }).then(data=>{
          execQuery(conn, 'SELECT * FROM ro_item WHERE pid=?', [item.pid]).then(result=>{
            const product = result;
            product[0].simg=data[0].current_col_img;
            product[0].count = item.count;
            product[0].selected = true;
            itemsList.push(product[0]);
            progress++;
            if(progress==items.length){
              console.log(itemsList);
              res.json(itemsList);
              conn.release(); 
            }         
          })
        });               
      })
     
       //const product =  getProduct(conn,item.pid);
       //console.log(product)
      // product[0].simg = simg;
      // product[0].count = item.count;
      // product[0].selected = true;
      // itemsList.push(product[0]);
  }
  // if(itemsList.length>=1){
  //   console.log(itemsList+"lizhan")
  // }
    //getConn().release();
    
    

  },
  count: (req,res) => {
    const items = JSON.parse(req.body.cartItems);
    const sessionItems = req.session.items;//读取session
    //判断如果前台发过来的pid，cid和session里的匹配，就把count设置为前台发来的
    items.forEach((v) => {
      sessionItems.forEach((d) => {
        if(v.pid == d. pid && v.cid == d.cid) {
          d.count = v.count
        }
      })
    })
    req.session.items = sessionItems;//保存session
    //连接数据库，查看产品数量
    res.json(items);
  },
  delete: (req,res) => {
    const items = JSON.parse(req.body.cartItems);
    req.session.items = items;
    res.json(items);
  },
  cartItems: (req,res)=>{
   const sessionItems =  req.session.items ;
   if( sessionItems !== undefined && sessionItems.length !== 0) {
     res.json({data: true});
   }else {
     res.json({data: false})
   }
  }
};
