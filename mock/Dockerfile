FROM quay.io/ukhomeofficedigital/openjdk8:v1.0.1
RUN curl -o /tmp/wiremock.jar https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/2.1.12/wiremock-standalone-2.1.12.jar
EXPOSE 8080
ADD docker-helpers/docker_entrypoint.sh /docker_entrypoint.sh
ADD . /mock
WORKDIR /mock

ENTRYPOINT ["/docker_entrypoint.sh"]