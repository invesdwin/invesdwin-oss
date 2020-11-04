#!/bin/bash
set -e
cd "$(dirname "$0")"
echo "-- invesdwin-bom"
mvn -B clean install -DskipTests -N -e -f invesdwin-bom/invesdwin-bom/pom.xml
echo "-- invesdwin-maven-plugin"
mvn -B clean install -DskipTests -T1C -U -e -f invesdwin-maven-plugin/invesdwin-maven-plugin-parent/pom.xml
echo "-- invesdwin-nowicket-parent"
mvn -B clean install -DskipTests -N -e -f invesdwin-nowicket/invesdwin-nowicket-parent/pom.xml
echo "-- invesdwin-context-parent"
mvn -B clean install -DskipTests -N -e -f invesdwin-context/invesdwin-context-parent/pom.xml
echo "-- invesdwin-context-integration-parent"
mvn -B clean install -DskipTests -N -e -f invesdwin-context-integration/invesdwin-context-integration-parent/pom.xml
echo "-- invesdwin-context-persistence-parent"
mvn -B clean install -DskipTests -N -e -f invesdwin-context-persistence/invesdwin-context-persistence-parent/pom.xml
echo "-- invesdwin-context-security-parent"
mvn -B clean install -DskipTests -N -e -f invesdwin-context-security/invesdwin-context-security-parent/pom.xml
echo "-- invesdwin-context-r-parent"
mvn -B clean install -DskipTests -N -e -f invesdwin-context-r/invesdwin-context-r-parent/pom.xml
echo "-- invesdwin-context-python-parent"
mvn -B clean install -DskipTests -N -e -f invesdwin-context-python/invesdwin-context-python-parent/pom.xml
echo "-- invesdwin-context-matlab-parent"
mvn -B clean install -DskipTests -N -e -f invesdwin-context-matlab/invesdwin-context-matlab-parent/pom.xml
echo "-- invesdwin-context-client-parent"
mvn -B clean install -DskipTests -N -e -f invesdwin-context-client/invesdwin-context-client-parent/pom.xml
echo "-- invesdwin-webproxy-parent"
mvn -B clean install -DskipTests -N -e -f invesdwin-webproxy/invesdwin-webproxy-parent/pom.xml
echo "-- build all"
mvn -B clean install -Pjacoco -T4 -e -Dmaven.test.failure.ignore=true
