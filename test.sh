#!/bin/bash
set -e
cd "$(dirname "$0")"
REPO=$HOME/.m2/repository-jacoco
echo "-- invesdwin-bom"
mvn -B -Dmaven.repo.local=$REPO clean install -DskipTests -N -e -f invesdwin-bom/invesdwin-bom/pom.xml
echo "-- invesdwin-maven-plugin"
mvn -B -Dmaven.repo.local=$REPO clean install -DskipTests -T1C -U -e -f invesdwin-maven-plugin/invesdwin-maven-plugin-parent/pom.xml
echo "-- invesdwin-nowicket-parent"
mvn -B -Dmaven.repo.local=$REPO clean install -DskipTests -N -e -f invesdwin-nowicket/invesdwin-nowicket-parent/pom.xml
echo "-- invesdwin-context-parent"
mvn -B -Dmaven.repo.local=$REPO clean install -DskipTests -N -e -f invesdwin-context/invesdwin-context-parent/pom.xml
echo "-- invesdwin-context-integration-parent"
mvn -B -Dmaven.repo.local=$REPO clean install -DskipTests -N -e -f invesdwin-context-integration/invesdwin-context-integration-parent/pom.xml
echo "-- invesdwin-context-persistence-parent"
mvn -B -Dmaven.repo.local=$REPO clean install -DskipTests -N -e -f invesdwin-context-persistence/invesdwin-context-persistence-parent/pom.xml
echo "-- invesdwin-context-security-parent"
mvn -B -Dmaven.repo.local=$REPO clean install -DskipTests -N -e -f invesdwin-context-security/invesdwin-context-security-parent/pom.xml
echo "-- invesdwin-context-client-parent"
mvn -B -Dmaven.repo.local=$REPO clean install -DskipTests -N -e -f invesdwin-context-client/invesdwin-context-client-parent/pom.xml
echo "-- invesdwin-scripting-parent"
mvn -B -Dmaven.repo.local=$REPO clean install -DskipTests -N -e -f invesdwin-scripting/invesdwin-scripting-parent/pom.xml
echo "-- invesdwin-webproxy-parent"
mvn -B -Dmaven.repo.local=$REPO clean install -DskipTests -N -e -f invesdwin-webproxy/invesdwin-webproxy-parent/pom.xml
echo "-- build all"
mvn -B -Dmaven.repo.local=$REPO clean install -Pjacoco -T4 -e -Dmaven.test.failure.ignore=true
