var express = require('express');
var uuid = require('uuid');

var users = [
   { id: "a", first: "firstA", last: "lastA", username: "testA@example.com"},
   { id: "b", first: "firstB", last: "lastB", username: "testB@example.com"}
]

function addUser(username, first, last) {
	return { id: uuid.v4(), first: first, last: last, username: username }
}

module.exports = {
	users,
	addUser
}