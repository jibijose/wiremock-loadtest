FROM openjdk:15-alpine

ENV WIREMOCK_VERSION 2.30.1
ENV JOLOKIA_VERSION 1.7.0

RUN mkdir -p /var/wiremock/lib/ && \
  wget https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-jre8-standalone/${WIREMOCK_VERSION}/wiremock-jre8-standalone-${WIREMOCK_VERSION}.jar -O /var/wiremock/lib/wiremock-jre8-standalone.jar && wget https://repo1.maven.org/maven2/org/jolokia/jolokia-jvm/${JOLOKIA_VERSION}/jolokia-jvm-${JOLOKIA_VERSION}.jar -O /var/wiremock/lib/jolokia-java-agent.jar  && \
  addgroup wiremock && \
  adduser --disabled-password --gecos '' --home /home/wiremock --ingroup wiremock wiremock && \
  chown --recursive wiremock:wiremock /home/wiremock

COPY entrypoint.sh /var/wiremock/entrypoint.sh
RUN dos2unix /var/wiremock/entrypoint.sh

WORKDIR /home/wiremock
USER wiremock


ENTRYPOINT [ "/var/wiremock/entrypoint.sh" ]