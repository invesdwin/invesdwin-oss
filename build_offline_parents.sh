#!/bin/bash
set -e
cd "$(dirname "$0")"

echo "-- invesdwin-bom"
mvn clean install -DskipTests -N -e -f invesdwin-bom/invesdwin-bom/pom.xml
echo "-- invesdwin-maven-plugin"
mvn clean install -DskipTests -T1C -e -f invesdwin-maven-plugin/invesdwin-maven-plugin-parent/pom.xml

echo "-- invesdwin-maven-plugin"
cd invesdwin-maven-plugin/invesdwin-maven-plugin-parent/
mvn clean install -DskipTests -T1C
cd ../../

echo "-- invesdwin-norva"
cd invesdwin-norva/invesdwin-norva/
mvn clean install -DskipTests -T1C
cd ../../

echo "-- invesdwin-util"
cd invesdwin-util/invesdwin-util-parent/
mvn clean install -DskipTests -T1C
cd ../../

echo "-- invesdwin-nowicket-parent"
mvn clean install -DskipTests -N -e -f invesdwin-nowicket/invesdwin-nowicket-parent/pom.xml
echo "-- invesdwin-context-parent"
mvn clean install -DskipTests -N -e -f invesdwin-context/invesdwin-context-parent/pom.xml
echo "-- invesdwin-context-persistence-parent"
mvn clean install -DskipTests -N -e -f invesdwin-context-persistence/invesdwin-context-persistence-parent/pom.xml
echo "-- invesdwin-context-security-parent"
mvn clean install -DskipTests -N -e -f invesdwin-context-security/invesdwin-context-security-parent/pom.xml
echo "-- invesdwin-context-integration-parent"
mvn clean install -DskipTests -N -e -f invesdwin-context-integration/invesdwin-context-integration-parent/pom.xml
echo "-- invesdwin-context-client-parent"
mvn clean install -DskipTests -N -e -f invesdwin-context-client/invesdwin-context-client-parent/pom.xml
echo "-- invesdwin-scripting-parent"
mvn clean install -DskipTests -N -e -f invesdwin-scripting/invesdwin-scripting-parent/pom.xml
echo "-- invesdwin-webproxy-parent"
mvn clean install -DskipTests -N -e -f invesdwin-webproxy/invesdwin-webproxy-parent/pom.xml
