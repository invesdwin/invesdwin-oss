#!/bin/bash
set -e
cd "$(dirname "$0")"

# use this script to build invesdwin-oss from scratch even if the invesdwin maven repository is offline (in emergency cases).
# this script builds required dependencies, makes sure parent poms are installed and then triggers a full build

# If repositories are offline and you want to build with maven-central only: 
#  you might have to delete the <repositories> and <pluginRepositories> tags from all pom.xml files 
#  so that all references to invesdwin-oss-remote and invesdwin-oss repository are removed

echo "-- maven-enforcer"
cd dependencies/maven-enforcer
mvn clean install -DskipTests -T1C
cd ../../

echo "-- license-check"
cd dependencies/license-check
mvn clean install -DskipTests -T1C
cd ../../


# WARNING: make sure a java 8 version is both in PATH and JAVA_HOME
# otherwise compilation will fail with sun.misc.Cleaner not being found
echo "-- fast-serialization"
cd dependencies/fast-serialization/
mvn clean install -DskipTests -T1C
cd ../../

echo "-- t-digest"
cd dependencies/t-digest/
mvn clean install -DskipTests -T1C
cd ../../

# WARNING: make sure a java 8 version is both in PATH and JAVA_HOME
# otherwise compilation will fail due to tools.jar not being found
echo "-- DockingFrames"
cd dependencies/DockingFrames/
mvn clean install -DskipTests -T1C
cd ../../

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
echo "-- invesdwin-context-r-parent"
mvn clean install -DskipTests -N -e -f invesdwin-context-r/invesdwin-context-r-parent/pom.xml
echo "-- invesdwin-context-python-parent"
mvn clean install -DskipTests -N -e -f invesdwin-context-python/invesdwin-context-python-parent/pom.xml
echo "-- invesdwin-context-matlab-parent"
mvn clean install -DskipTests -N -e -f invesdwin-context-matlab/invesdwin-context-matlab-parent/pom.xml
echo "-- invesdwin-context-client-parent"
mvn clean install -DskipTests -N -e -f invesdwin-context-client/invesdwin-context-client-parent/pom.xml
echo "-- invesdwin-webproxy-parent"
mvn clean install -DskipTests -N -e -f invesdwin-webproxy/invesdwin-webproxy-parent/pom.xml
echo "-- build all"
# builds will fail at some point when missing artifacts are encountered, 
# these need to be sourced from other repos with a custom settings.xml, 
# though some native libs need to be built manually; though invesdwin-instrument and some other projects will build fine here
mvn clean install -DskipTests -T1C -e
