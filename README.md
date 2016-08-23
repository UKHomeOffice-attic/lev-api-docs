# LEV API Docs

This documentation is used to:
- Provide developers with documentation for using the LEV API
- Provide the contract for the LEV API, including example responses
- Provide a mock version of the LEV API
- Provide end to end tests against the API

## General pre-requisites
To run any of the tasks in this repository you will need npm and nodeJS installed.

## API Documentation
API documentation is available [here](https://htmlpreview.github.io/?https://github.com/UKHomeOffice/lev-api-docs/blob/master/html-docs/lev-api.html)

## Running a mock version of the API

### Pre-requisites
drakov is required (though will also be installed in node_modules directory if needed)
```bash
npm install -g drakov
```

### Running the mock
```bash
drakov -f lev-api.md -p 8080 --discover -s html-docs
```

-p defines the port

--discover gives a /drakov endpoint which lists available urls

-f is a global to the specification file

-s gives a /lev-api.html endpoint (gives endpoints for all static files here)

## Running the E2E tests

### Pre-requisites
docker-compose is required
dredd is required (though will also be installed in node_modules directory if needed)
```bash
npm install -g dredd
```

Install all dependencies:
```bash
npm install
```

### Running tests with the server already running
```bash
dredd lev-api.md http://localhost:8080 
```

### Running tests against server with oauth2 authentication enabled (assuming server running already)
Environment variables need to be set for oauth properties, e.g.
```bash
KEYCLOAK_U=dredd-tests KEYCLOAK_P="xxxxx" REALM=lev-api-dev CLIENT_ID=dredd-tests CLIENT_SECRET=xxxxxx \
dredd lev-api.md http://localhost:8080 --server false --server-wait 0 --hookfiles=./hooks/oauth2.js
```

### Running tests with docker
```bash
docker build -t lev-api-e2e-tests .
docker run --rm -e KEYCLOAK_U=dredd-tests -e KEYCLOAK_P="xxxxxx" \
-e REALM=lev-api-dev -e CLIENT_ID=dredd-tests -e \
CLIENT_SECRET=xxxxxx lev-api-e2e-tests \
lev-api.md https://lev-api-dev.notprod.homeoffice.gov.uk \
--hookfiles=./hooks/oauth2.js
```

### Viewing full test report
Open the report.html file that is generated after running the tests

## Generating a nice HTML version of the documentation
There is a git hook to update the html version of the documentation on commit.

### Generating html docs manually
```bash
./node_modules/.bin/aglio -i lev-api.md -o html-docs/lev-api.html
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).

## License

This project is licensed under the GPLv2 License - see the [LICENSE.md](LICENSE.md) file for details
