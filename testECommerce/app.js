var express = require('express');
var path = require('path');
var logger = require('morgan');
var cookieParser = require('cookie-parser')
var usersRouter = require('./routes/users');
var authRouter = require('./routes/auth');

var usersData = require('./data/users');
var sessionData = require('./data/session');

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/users', usersRouter);
app.use('/auth', authRouter);

app.use(function(req, res, next) {
  res.status(404).json({ message: "Invalid request" });
});

module.exports = app;
