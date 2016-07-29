mvn clean deploy -DskipTests -U -N -e -f invesdwin-bom/invesdwin-bom/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-maven-plugin/invesdwin-maven-plugin-parent/pom.xml
mvn clean deploy -DskipTests -U -N -e -f invesdwin-context/invesdwin-context-parent/pom.xml
