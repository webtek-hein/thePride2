'use strict';

// ========================================================
// Load necessary modules =================================
const express = require('express');
const session = require('express-session');
const config = require('config');
const cookieParser = require('cookie-parser');
const bodyParser = require('body-parser');
const app = express();


// Set-up views in order for the engine to identify that we will use ejs file type as html
app.set('view engine', 'ejs');
app.set('views', __dirname, + '/views');


// Set-up the cookie
app.use(cookieParser());
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

// Set-up the session for the user
app.use(session({
    secret: config.get('cookie.secret'),
    resave: true,
    saveUninitialized: true
}));

require('../../app/routes.js')(app);

module.exports = app;