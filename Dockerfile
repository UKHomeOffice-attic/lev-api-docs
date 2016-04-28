FROM quay.io/ukhomeofficedigital/nodejs-base:v4.4.2

RUN yum clean all && \
    yum update -y && \
    yum install -y git make gcc-c++ psmisc && \
    yum clean all && \
    rpm --rebuilddb && \
    mkdir -p /app/mock

WORKDIR /tests
COPY ./package.json /tests/
RUN npm install --quiet

COPY . /tests

ENTRYPOINT ["/tests/node_modules/dredd/bin/dredd"]