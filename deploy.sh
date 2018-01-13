#!/bin/bash
set -e
cd "$(dirname "$0")"
mvn clean deploy -DskipTests -U -N -e -f invesdwin-bom/invesdwin-bom/pom.xml
mvn clean deploy -DskipTests -T1C -U -e -f invesdwin-maven-plugin/invesdwin-maven-plugin-parent/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-context/invesdwin-context-parent/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-context-integration/invesdwin-context-integration-parent/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-context-persistence/invesdwin-context-persistence-parent/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-context-security/invesdwin-context-security-parent/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-context-r/invesdwin-context-r-parent/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-context-python/invesdwin-context-python-parent/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-context-matlab/invesdwin-context-matlab-parent/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-context-client/invesdwin-context-client-parent/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-webproxy/invesdwin-webproxy-parent/pom.xml
mvn clean deploy -DskipTests -T1C -U -e
