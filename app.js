//imports
const express = require('express')
const app = express()
const port = 5000;

app.use(express.static('public'));
app.use("/css",express.static(__dirname + 'public/css'))
app.use("/js",express.static(__dirname + 'public/js'))
app.use("/images",express.static(__dirname + 'public/images'))
app.set('views','./views')
app.set('view engine','ejs')

//client connection
const {Client} = require('pg');
const client = new Client({
    host: "localhost",
    user: "postgres",
    port: 5432,
    password: "easy",
    database: "ecommerce"
});
client.connect();

app.get('/',(req,res) =>{
    res.render('index', { data: {result:[] , err:[]}});
})

app.get('/erdiagram',(req,res) =>{
    res.render('erdiagram');
})

app.get('/table',(req,res) =>{
    //console.log(req.query.query);
    if(req.query.query){
        client.query(req.query.query, (error,result)=>{
            if(!error) {
                //console.log(result.rows);
                res.render('table', { data: {result:result.rows , err:[]}});
            } else{
                //console.log(error.message);
                res.render('table', {data: {err:{name:error.message}, result:[] }});
            }
        });
        
    }
    else res.render('table',{ data: {result:[] , err:[]}});
})

app.get('/query',(req,res) =>{
    //console.log("here "+req.query.query);
    client.query(req.query.query, (error,result)=>{
        if(!error) {
            //console.log(result.rows);
            res.render('index', { data: {result:result.rows , err:[]}});
        } else{
            //console.log(error.message);
            res.render('index', {data: {err:{name:error.message}, result:[] }});
        }
    });
})
//listent to port 5000
app.listen(port, () => console.info('Listening to the port 5000'));

