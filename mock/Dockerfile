FROM quay.io/ukhomeofficedigital/openjdk8-jre:v0.2.2
RUN curl -o /tmp/wiremock.jar https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/2.1.12/wiremock-standalone-2.1.12.jar
EXPOSE 8080
ADD . /mock
WORKDIR /mock
RUN chmod +x docker-helpers/entrypoint.sh

ENTRYPOINT ["docker-helpers/entrypoint.sh"]
