var express = require('express');
var router = express.Router();
var usersData = require('../data/users')
var sessionData = require('../data/session')

router.post('/signin', function(req, res, next) {
  const user_username = req.body.username;
  if (user_username) {
    for (let user of usersData) {
      if (user.username == user_username) {
      	  sessionData.setAuthtoken(user_username);
	      res.set('authtoken', user_username);
    	  res.status(200).json(user);
          return
      }
    }
  }
  res.status(401).json({ message: "Authentication failed." });
});

router.post('/signout', function(req, res, next) {
	sessionData.clearAuthtoken();
	res.status(200).json({});
});

module.exports = router;
