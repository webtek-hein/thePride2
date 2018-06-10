'use strict'

const express = require('express');
const dbconfig = require('../database/database');
const bodyParser = require('body-parser');

const formidable = require('formidable');

const mysql = require('mysql');
const url = require('url');
const str = require('string');
const StringBuilder = require('string-builder')
const app = express();

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
        res.render('../../frontend/authenticate/views/login.ejs', { message: req.flash('loginMessage') });
    });

    // ============================================================================
    // ================================= LOGIN ====================================
    // ============================================================================
    app.get('/login', function (req, res) {
        res.redirect('../../frontend/authenticate/views/login.ejs', { message: req.flash('loginMessage') });
    })

    app.post('/login', passport.authenticate('local-login', {
        successRedirect: '/index',
        failureRedirect: '/index',
        failureFlash: true
    }),
        function (req, res) {
            if (req.body.remember) {
                req.session.cookie.maxAge = 1000 * 60 * 4;
            } else {
                req.session.cookie.expires = false;
            }

            res.redirect('/');
        });
    // PROTECTED
    // ============================================================================
    // ============================================================================
    app.get('/index', function (req, res) {
        res.render('../../frontend/general/views/index.ejs');
    });
     app.get('/carRes', function (req, res) {
        var car_id = req.query.carid;

        var query = "SELECT * FROM findcar ";

        connection.query(query, [car_id], function (err, row_car_info) {
            if (err) {

            } else {
                res.render('/carFind', { car_info: row_car_info[0] });
            }
        });
    });
   
    app.get('/driverinfo', function (req, res) {
        res.render('../../frontend/general/views/driverinfo.ejs');
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


    app.post('/carFind', function (req, res) {

        var priceRange = req.body.priceRange;
        var location = req.body.location;
        var capacity = req.body.capacity;
        
        var rendData = {
            pickUpLocation : location,
            pickupDate : req.body.rentDate,
            dropOffDate : req.body.dropoffDate,
        }


        // var query_string = "INSERT INTO findcar (pickup_locationfc, pickup_datefc, pickup_timefc, dropoff_locationfc, dropoff_datefc, dropoff_timefc, price_rangefc) VALUES(?,?,?,?,?,?,?)"

        // connection.query(query_string, [req.body.pickup_location, req.body.pickup_date, req.body.pickup_time, req.body.dropoff_location, req.body.dropoff_date, req.body.dropoff_time, req.body.price_range], function (err, rows) {
        //     if (err) {
        //         console.log(err);
        //     } else {
                var query_string = `SELECT address,firstname,lastname,vehicle.* FROM vehicle 
                    inner join user on user.user_Id = vehicle.spID
                    where vehicleStatus = 'available'
                    AND address = ? AND capacity <= ?
                    AND rent_Price <= ?`;
                connection.query(query_string,[location,capacity,priceRange], function (err, pCar) {

                    var newCar = pCar.length;
                    var Specs = [];

                    for (var i = 0; i < newCar; i++) {
                        Specs.push(pCar[i]);
                    }
                    res.render('../../frontend/general/views/carRes.ejs', {reservation: rendData, Specs: Specs });
                });
            // }
        // });
    });
};


// query 1 "SELECT * user_credential uc JOIN user_profile up on uc.sg_email = up.email WHERE(SE) ";

