#!/bin/bash
set -e
cd "$(dirname "$0")"
mvn clean deploy -DskipTests -U -N -e -f invesdwin-bom/invesdwin-bom/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-context/invesdwin-context-parent/pom.xml
mvn clean deploy -DskipTests -T1C -U -e
