var hooks = require('hooks');
var request = require('request');


var responseStash = {};

hooks.beforeAll(function (transactions, done) {
  var clientId = process.env.CLIENT_ID;
  var clientSecret = process.env.CLIENT_SECRET;
  var realm = process.env.REALM;
  var userName = process.env.KEYCLOAK_U;
  var password = process.env.KEYCLOAK_P;

  if (typeof clientId === 'undefined' || typeof clientSecret === 'undefined' || typeof realm === 'undefined' ||
    typeof userName === 'undefined' || typeof password === 'undefined') {
    throw new Error("If using oAuth2 hook you must set env vars for CLIENT_ID, CLIENT_SECRET, REALM, KEYCLOAK_U, KEYCLOAK_P");
  }

  var base64Auth = new Buffer(clientId + ":" + clientSecret).toString('base64');

  var authHeader = "Basic " + base64Auth;
  request.post({
    url: "https://sso.digital.homeoffice.gov.uk/auth/realms/"+realm+"/protocol/openid-connect/token",
    form: {
      grant_type: "password",
      username: userName,
      password: password
    },
    headers: {
      Authorization: authHeader
    }

  }, function (err, res, body) {
    responseStash.accessToken = JSON.parse(res.body).access_token;
    done();
  });

});

hooks.beforeEach(function (transaction, done) {
  transaction.request['headers']['Authorization'] = "Bearer " + responseStash.accessToken;
  done();
});
