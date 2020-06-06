var express = require('express');
var router = express.Router();
var usersData = require('../data/users')
var sessionData = require('../data/session')
var error = require('../data/error')

router.post('/signin', function(req, res, next) {
  const user_username = req.body.username;
  if (user_username) {
    for (let user of usersData.users) {
      if (user.username == user_username) {
      	  sessionData.setAuthtoken(user_username);
	      res.set('authtoken', user_username);
    	  res.status(200).json(user);
          return
      }
    }
  }
  res.status(401).json(error(103, "Authentication failed." ));
});

router.post('/register', function(req, res, next) {
  const user_username = req.body.username;
  const user_first = req.body.first;
  const user_last = req.body.last;
  if (user_username && user_first && user_last) {
    for (let user of usersData.users) {
      if (user.username == user_username) {
		res.status(422).json(error(104, "Username already exists" ));
		return
      }
    }
    user = usersData.addUser(user_username, user_first, user_last);
	sessionData.setAuthtoken(user_username);
	res.set('authtoken', user_username);
	res.status(200).json(user);
	return
  }
  res.status(422).json(error(105, "A required field is missing: username, first, last" ));
});

router.post('/signout', function(req, res, next) {
	sessionData.clearAuthtoken();
	res.status(200).json({});
});

module.exports = router;
