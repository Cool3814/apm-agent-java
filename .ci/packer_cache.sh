#!/usr/bin/env bash
source /usr/local/bin/bash_standard_lib.sh

JAVA_HOME=$HOME/.java/java11 ./mvnw clean verify \
  --fail-never -q -B \
  -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn

if [ -x "$(command -v docker)" ]; then
  (retry 2 docker pull docker.elastic.co/observability-ci/weblogic:12.2.1.3-dev) \
    && docker tag docker.elastic.co/observability-ci/weblogic:12.2.1.3-dev store/oracle/weblogic:12.2.1.3-dev
fi
