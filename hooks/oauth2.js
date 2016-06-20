var hooks = require('hooks');
var request = require('request');
var qs = require('querystring');

var responseStash = {};

hooks.beforeAll(function (transactions, done) {
  var realm = process.env.REALM;
  var username = process.env.KEYCLOAK_U;
  var password = process.env.KEYCLOAK_P;

  if (typeof username === 'undefined' || typeof password === 'undefined') {
    throw new Error("If using oAuth2 hook you must set env vars for REALM, KEYCLOAK_U, KEYCLOAK_P");
  }

  const url = transactions[0].protocol + "//" + transactions[0].host + "/oauth/login?";

  request.post({
    url: url,
    form: {
      username: username,
      password: password
    }
  }, function (err, res, body) {
    responseStash.accessToken = JSON.parse(body).access_token;
    done();
  });

});

hooks.beforeEach(function (transaction, done) {
  transaction.request['headers']['Authorization'] = "Bearer " + responseStash.accessToken;
  done();
});
