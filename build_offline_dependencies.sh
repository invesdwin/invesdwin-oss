#!/bin/bash
set -e
cd "$(dirname "$0")"

# use this script to build invesdwin-oss from scratch even if the invesdwin maven repository is offline (in emergency cases).
# this script builds required dependencies, makes sure parent poms are installed and then triggers a full build

# If repositories are offline and you want to build with maven-central only: 
#  you might have to delete the <repositories> and <pluginRepositories> tags from all pom.xml files 
#  so that all references to invesdwin-oss-remote and invesdwin-oss repository are removed

#https://stackoverflow.com/questions/7334754/correct-way-to-check-java-version-from-bash-script
if type -p java; then
    echo found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME
    _java="$JAVA_HOME/bin/java"
else
    echo "no java"
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" = "1.8" ]]; then
        JAVA8="true"
    else
        echo "WARNING: skipping projects in build that require java 1.8 to build without errors"
        JAVA8="false"
    fi
fi


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
if [[ "$JAVA8" = "true" ]]; then
    echo "-- fast-serialization"
    cd dependencies/fast-serialization/
    mvn clean install -DskipTests -T1C
    cd ../../
fi

echo "-- t-digest"
cd dependencies/t-digest/
mvn clean install -DskipTests -T1C
cd ../../

# WARNING: make sure a java 8 version is both in PATH and JAVA_HOME
# otherwise compilation will fail due to tools.jar not being found
if [[ "$JAVA8" = "true" ]]; then
    echo "-- DockingFrames"
    cd dependencies/DockingFrames/
    mvn clean install -DskipTests -T1C
    cd ../../
fi

echo "-- dynamicreports"
cd dependencies/dynamicreports/
mvn clean install -DskipTests -T1C
cd ../../

echo "-- JCOOL"
cd dependencies/JCOOL/jcool
mvn clean install -DskipTests -T1C
cd ../../../

echo "-- leveldb"
cd dependencies/leveldb/
mvn clean install -DskipTests -T1C
cd ../../

echo "-- ezdb"
cd dependencies/ezdb/
mvn clean install -DskipTests -T1C
cd ../../
