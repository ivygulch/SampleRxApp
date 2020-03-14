var express = require('express');

var session = [
//    authtoken: nil
]

function setAuthtoken(authtoken) {
	session.authtoken = authtoken
}

function clearAuthtoken() {
	delete session.authtoken
}

function validateUsername(username) {
	if (!session.authtoken || !username) {
		return false
	}
	return (username == session.authtoken)
}

function validateRequest(req) {
	if (!session.authtoken) {
		return false
	}
	return (req.get("authtoken") == session.authtoken)
}

module.exports = {
	setAuthtoken,
	clearAuthtoken,
	validateUsername,
	validateRequest
};