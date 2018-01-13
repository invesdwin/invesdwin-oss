#!/bin/bash
set -e
cd "$(dirname "$0")"

echo "-- invesdwin-bom"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-bom/invesdwin-bom/pom.xml
echo "-- invesdwin-maven-plugin"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-maven-plugin/invesdwin-maven-plugin-parent/pom.xml
echo "-- invesdwin-instrument"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-instrument/invesdwin-instrument/pom.xml
echo "-- invesdwin-aspects"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-aspects/invesdwin-aspects/pom.xml
echo "-- invesdwin-norva"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-norva/invesdwin-norva/pom.xml
echo "-- invesdwin-util"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-util/invesdwin-util/pom.xml
echo "-- invesdwin-nowicket"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-nowicket/invesdwin-nowicket-parent/pom.xml
echo "-- invesdwin-context"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context/invesdwin-context-parent/pom.xml
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context/tests/otherproject-test-parent/pom.xml
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context/tests/otherproject-noparent-test/pom.xml
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context/tests/otherproject-noparent-bom-test/pom.xml
echo "-- invesdwin-context-integration"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context-integration/invesdwin-context-integration-parent/pom.xml
echo "-- invesdwin-context-persistence"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context-persistence/invesdwin-context-persistence-parent/pom.xml
echo "-- invesdwin-context-security"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context-security/invesdwin-context-security-parent/pom.xml
echo "-- invesdwin-context-r"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context-r/invesdwin-context-r-parent/pom.xml
echo "-- invesdwin-context-python"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context-python/invesdwin-context-python-parent/pom.xml
echo "-- invesdwin-context-matlab"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context-matlab/invesdwin-context-matlab-parent/pom.xml
echo "-- invesdwin-context-client"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-context-client/invesdwin-context-client-parent/pom.xml
echo "-- invesdwin-webproxy"
mvn clean deploy -DskipTests -T1C -e -f invesdwin-webproxy/invesdwin-webproxy-parent/pom.xml

