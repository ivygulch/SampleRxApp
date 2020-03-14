var express = require('express');
var router = express.Router();
var usersData = require('../data/users')
var sessionData = require('../data/session')

router.get('/:id', function(req, res, next) {
	valid = sessionData.validateRequest(req)
	console.log('valid='+valid)
	if (!valid) {
		res.status(401).json({ message: "Not authorized" });
		return
	}
	const user_id = req.params.id;
	for (let user of usersData) {
		if (user.id == user_id) {
			if (sessionData.validateUsername(user.username)) {
				res.status(200).json(user)
				return
			}
		}
	}
	res.status(404).json({ message: "Invalid id: "+user_id });
});

module.exports = router;
