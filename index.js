const mysql = require("mysql")
const express = require("express")
const router = require('./routes');
const app = express()
const bodyparser = require("body-parser")
//var db=require('../database');
//------------------>
//app.use("/public", express.static(path.join(__dirname, "public")));

exports.app = app;

//app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');
//app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(router);
//------------------->

app.use(bodyparser.json())

let mysqlConnection = mysql.createConnection({
    host : '149.248.59.146',
    user : 'root',
    password : 'licornes_alk(83y3R!!T',
    //database : 'bookit',
    database : 'hotel',
    port : 6603,
    multipleStatements : true
})

mysqlConnection.connect((err) => {
    if(!err)
    console.log('DB connection succeded.')
    else
    console.log('DB connection failed \n Error : '+ JSON.stringify(err,undefined,2))
})

app.listen(3000, () => {
    console.log("express server ins running at port 3000")
})

//get all chambres in DB
app.get('/chambres', (req, res) => {
    mysqlConnection.query('SELECT * FROM chambre', (err, rows, fields) => {
        if(!err){
            console.log(rows)
            //res.send(rows)
            res.render("layouts/chambres.pug", {chambres: rows})
        }
        else
        console.log(err)
    })
})


//get all client in DB
app.get('/client', (req, res) => {
    mysqlConnection.query('SELECT * FROM client', (err, rows, fields) => {
        if(!err){
            console.log(rows)
            //res.send(rows)
            res.render("layouts/clients.pug", {clients: rows})
        }
        else
        console.log(err)
    })
})

//get all price in DB
/*app.get('/prix', (req, res) => {
    mysqlConnection.query('SELECT * FROM prix', (err, rows, fields) => {
        if(!err){
            console.log(rows)
            res.send(rows)
        }
        else
        console.log(err)
    })
})*/

//get all reservation in DB
app.get('/reservation', (req, res) => {
    mysqlConnection.query('SELECT * FROM reservation', (err, rows, fields) => {
        if(!err){
            console.log(rows)
            //res.send(rows)
            res.render("layouts/reservations.pug", {reservations: rows})
        }
        else
        console.log(err)
    })
})

//get a chambres from DB
app.get('/chambres/:id', (req, res) => {
    mysqlConnection.query('SELECT * FROM chambres WHERE ChambreID = ?', [req.params.id],(err, rows, fields) => {
        if(!err){
            //console.log(rows)
            res.send(rows)
        }
        else
        console.log(err)
    })
})

//delete a chambres from DB
app.delete('/chambres/:id', (req, res) => {
    mysqlConnection.query('DELETE FROM chambres WHERE ChambreID = ?', [req.params.id],(err, rows, fields) => {
        if(!err){
            //console.log(rows)
            res.send("deleted successfully!")
        }
        else
        console.log(err)
    })
})

//insert a chambre in the DB
app.post('/chambres/', (req, res) => {
    let chm = req.body
    let sql = "SET @ChambreID = ?; SET @Name = ?, SET @Type = ?; SET @Occupation = ?; \
    CALL ChambreAddOrEdit(@ChambreID,@Name,@Type,@Occupation);"
    mysqlConnection.query(sql, [chm.ChambreID, chm.Name, chm.Type, chm.Occupation],(err, rows, fields) => {
        if(!err)
        rows.array.forEach(element => {
            if(element.constructor == Array)
            res.send('Inserted chambre id : '+ element[0].ChambreID)
        });
        else
        console.log(err)
    })
})

//update a chambre in the DB
app.put('/chambres/', (req, res) => {
    let chm = req.body
    let sql = "SET @ChambreID = ?; SET @Name = ?, SET @Type = ?; SET @Occupation = ?; \
    CALL ChambreAddOrEdit(@ChambreID,@Name,@Type,@Occupation);"
    mysqlConnection.query(sql, [chm.ChambreID, chm.Name, chm.Type, chm.Occupation],(err, rows, fields) => {
        if(!err)
        res.send("Updated successfully!")
        else
        console.log(err)
    })
})

