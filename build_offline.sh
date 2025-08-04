#!/bin/bash
set -e
cd "$(dirname "$0")"

./build_offline_dependencies.sh
./build_offline_parents.sh

# builds will fail at some point when missing artifacts are encountered, 
# these need to be sourced from other repos with a custom settings.xml, 
# though some native libs need to be built manually; though invesdwin-instrument and some other projects will build fine here
mvn clean install -DskipTests -T1C -e
