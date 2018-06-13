'use strict'

const express = require('express');
const dbconfig = require('../database/database');
const bodyParser = require('body-parser');
const config = require('config');


const formidable = require('formidable');

const mysql = require('mysql');
const url = require('url');
const str = require('string');
const StringBuilder = require('string-builder')
const app = express();

const moment = require('moment');

const appRoot = require('app-root-path');

app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

const connection = mysql.createConnection(dbconfig.connection);
connection.query('USE ' + dbconfig.database);

module.exports = function (app, passport) {

    // ============================================================================
    // =============================== HOME PAGE ==================================
    // ============================================================================
    app.get('/', function (req, res) {
        res.redirect('/login');
    });
    app.get('/login',function(req,res){
        res.redirect(config.get('main.login'));
    })

   app.get('/index/:uID',function(req,res) {
        var session = req.session;
        var uID = req.params.uID;
        if(session.userData){
            res.redirect('/index');
        }else{
            var query = "SELECT user_Id,firstname,lastname FROM user where user_Id = ? AND status = 'activated'";

        connection.query(query, [uID], function (err, userData) {
            if (err) {
                console.log(err);
            } else {
                session.userData = userData[0];
                res.redirect('/index');
            }
        });
        }
       


   });
    app.get('/index', function (req, res) {
        var userData = req.session.userData;
        if(!userData){
            res.redirect('/login');
        }else{
            res.render('../../frontend/general/views/index.ejs');
        }
    });
     app.get('/carRes', function (req, res) {
        var car_id = req.query.carid;
        var userData = req.session.userData;
        if(!userData){
            res.redirect('/login');
        }else{
        var query = "SELECT * FROM findcar ";

        connection.query(query, [car_id], function (err, row_car_info) {
            if (err) {

            } else {
                res.render('/carFind', { car_info: row_car_info[0] });
            }
        });
        }
   
    });
   
    app.get('/reservation/:vID/:uID', function (req, res) {
        var vID = req.params.vID;
        var uID = req.params.uID;
        var rentStartdate = req.session.rentData.pickupDate;
        var rentEnddate = req.session.rentData.dropOffDate;
          var userData = req.session.userData;
        if(!userData){
            res.redirect('/login');
        }else{
          var query = `INSERT INTO request (userID,vehicleID,requestType,status,rentStartdate,rentEnddate) 
        values (?,?,'reservation','pending',?,?)`;

        connection.query(query, [uID,vID,rentStartdate,rentEnddate], function (err, row_car_info) {
            if (err) {
                console.log(err);
            } else {
                req.session.vehicle = vID;
                req.session.request = row_car_info.insertId;
                res.redirect('/reservation');
            }
        });  
        }

        
    });
    app.get('/book/:vID/:reqID',function(req,res){
        req.session.vehicle = req.params.vID;
        req.session.request = req.params.reqID;
        res.redirect('/reservation');
    });
    app.get('/reservation', function (req, res) {
        var userData = req.session.userData;
        var vID = req.session.vehicle;
        var req = req.session.request;
        if(!userData){
            res.redirect('/login');
        }else{
        var query_string = `SELECT request.requestID,rentStartdate,rentEnddate,request.status,address,firstname,lastname,vehicle.* FROM vehicle 
                    inner join user on user.user_Id = vehicle.spID
                    inner join request on request.vehicleID = vehicle.vehicleID
                    where request.vehicleID = ? AND request.requestID = ?`;
                connection.query(query_string,[vID,req], function (err, pCar) {
                    if (err) console.log(err);

                    var newCar = pCar.length;
                    var Specs = [];
                    for (var i = 0; i < newCar; i++) {
                        Specs.push(pCar[i]);
                    }
                    res.render('../../frontend/general/views/driverinfo.ejs', {Specs: Specs,user:userData.user_Id, moment: moment});
                });  
        }
    });
    app.get('/payment', function (req, res) {
        res.render('../../frontend/general/views/payment.ejs');
    });
    app.get('/viewmore', function (req, res) {
        res.render('../../frontend/general/views/viewmore.ejs');
    });

    app.get('/register', function (req, res) {
        res.render('../../frontend/general/views/register.ejs');
    });

    app.get('/bookRes/:reqID',function(req,res){
        var reqID = req.params.reqID;
        var query_string = `UPDATE request SET requestType = 'rent', status='booking' WHERE request.requestID = ? `;
        connection.query(query_string, [reqID], function (err, rows) {
            if(err) console.log(err);
            else{
                res.redirect('/manage');
            }
        });

    });

    app.get('/cancel/:reqID/:vehicleID',function(req,res){
        var requestID = req.params.reqID;
        var vehicleID = req.params.vehicleID;
        var query_string = `UPDATE request SET status='cancelled' WHERE request.requestID = ? `;
        connection.query(query_string, [requestID], function (err, rows) {
            if(err) console.log(err);
            else{
                 var query_string = `UPDATE vehicle SET vehicleStatus='available' WHERE vehicleID = ? `;
                 connection.query(query_string, [vehicleID], function (err, rows) {
                    if(err) console.log(err);
                    else{
                    res.redirect('/manage');
                    }
                });
            }
        });

    });

    app.get('/manage',function(req,res){
        if(req.session.userData){
        var uID = req.session.userData.user_Id;
                  var query_string = `Select request.status,request.vehicleID,request.requestID,firstname,lastname,address,model,capacity,rent_price,brand,request.* from request 
         inner join vehicle on vehicle.vehicleID = request.vehicleID
         inner join user on user.user_Id = vehicle.spID
         where request.userID = ? AND request.requestType='reservation' AND request.status in ('pending','approved')`;
        connection.query(query_string, [uID], function (err, rows) {
            if (err) {
                console.log(err);
            } else {
               var reservations = rows;
        query_string = `Select request.status,request.vehicleID,request.requestID,firstname,lastname,address,model,capacity,rent_price,brand,request.* from request 
         inner join vehicle on vehicle.vehicleID = request.vehicleID
         inner join user on user.user_Id = vehicle.spID
         where request.userID = ? AND request.requestType='rent' AND request.status in ('booking','booked')`;
        connection.query(query_string, [uID], function (err, rows) {
            if (err) {
                console.log(err);
            } else {
                var booking =  rows;
                res.render('../../frontend/general/views/reservation.ejs',{booking: booking, reservations: reservations, moment: moment});
            }
            });
            }
        });   
    }else{
        res.redirect(config.get('main.login'));
    }

    });
    app.get('/transactions',function(req,res){
        if(req.session.userData){
        var uID = req.session.userData.user_Id;
        var query_string = `Select requestType,request.status,request.vehicleID,request.requestID,firstname,lastname,address,model,capacity,rent_price,brand,request.* from request 
         inner join vehicle on vehicle.vehicleID = request.vehicleID
         inner join user on user.user_Id = vehicle.spID
         where request.userID = ? AND request.status in ('finished','cancelled','rejected')
         Order by request.requestID DESC`;
        connection.query(query_string, [uID], function (err, rows) {
            if (err) {
                console.log(err);
            } else {
                res.render('../../frontend/general/views/transactions.ejs',{transactions: rows, moment: moment});
            }
            });
        }else{
        res.redirect('/login');
    }


    });
    app.get('/logout',function(req,res){
        req.session.destroy(function(err){  
        if(err){  
            console.log(err);  
        }  
        else  
        {  
            res.redirect(config.get('main.url'));  
        }  
    });  

    });
    app.post('/newClient', function (req, res) {

        console.log(req.body.first_Name);
        console.log(req.body.last_Name);
        console.log(req.body.address);
        console.log(req.body.contact_No);
        console.log(req.body.acc_Type);
        console.log(req.body.username);
        console.log(req.body.password);
        var query_string = "INSERT INTO user (first_Name,last_Name,address,contact_No,acc_Type,username,password) VALUES(?,?,?,?,?,?,?)"
        connection.query(query_string, [req.body.first_Name, req.body.last_Name, req.body.address, req.body.contact_No, req.body.acc_Type, req.body.username, req.body.password], function (err, rows) {
            if (err) {
                console.log(err);
            } else {
            }
            res.redirect('/');   
        });
    });

    app.post('/contact', function (req, res){
        var contact = req.body;
        console.log(contact.firstname);
        console.log(contact.lastname);
        console.log(contact.info_email);
        console.log(contact.mobileNo);

        var query_string = "INSERT INTO contact (firstname, lastname, info_email,mobileNo) VALUES(?,?,?,?)";
        connection.query(query_string, [contact.firstname, contact.lastname, contact.info_email, contact.mobileNo], function(err, rows){
        if (err) {
            console.log(err);
        } else {
            //
            console.log('saved');
        }
        res.render('../../frontend/general/views/payment.ejs');
        });
    });
     app.post('/contact', function (req, res){
  
    });


    app.post('/carFind', function (req, res) {
        var userData = req.session.userData;
        if(!userData){
            res.redirect('/login');
        }else{
        var priceRange = req.body.priceRange;
        var location = req.body.location;
        var capacity = req.body.capacity;
        var uID = userData.user_Id;
        
        var rentData = {
            pickUpLocation : location,
            pickupDate : req.body.rentDate,
            dropOffDate : req.body.dropoffDate,
        }
        req.session.rentData = rentData;

                var query_string = `SELECT address,firstname,lastname,vehicle.* FROM vehicle 
                    inner join user on user.user_Id = vehicle.spID
                    where vehicleStatus = 'available'
                    AND address = ? AND capacity <= ?
                    AND rent_Price <= ?
                    AND vehicleID not in (SELECT vehicleID from request where userID = ? AND 
                    status not in ('finished','cancelled','rejected'))`;
                connection.query(query_string,[location,capacity,priceRange,uID], function (err, pCar) {

                    var newCar = pCar.length;
                    var Specs = [];
                    if (err) console.log(err);
                    for (var i = 0; i < newCar; i++) {
                        Specs.push(pCar[i]);
                    }
                    res.render('../../frontend/general/views/carRes.ejs', {reservation: rentData, Specs: Specs,user:uID });
                });  
        }
      
    });
};