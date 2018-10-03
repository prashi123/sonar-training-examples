#!/bin/bash

testFile="src/test/java/coverage_metrics/CoverageMetricsTest.java"

if [ "$1" = "-h" ] || [ "$1" = "-?" ]; then
	echo "Usage: $0 [-h|-?] [<scanner-properties>]"
	echo ""
	echo "Example: $0 -Dsonar.host.url=http://localhost:9000"
	exit 0
elif [ "$1" = "1" ] || [ "$1" = "2" ] || [ "$1" = "all" ]; then
	ut=$1
	shift
	cp $testFile.ut$ut $testFile
fi

if [ "$SQ_URL" != "" ]; then
	sqHostOpt="-Dsonar.host.url=$SQ_URL"
fi
if [ "$TOKEN" != "" ]; then
	sqLoginOpt="-Dsonar.login=$TOKEN"
fi
mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install \
   -Dmaven.test.failure.ignore=true \
   sonar:sonar $sqHostOpt $sqLoginOpt \
   -Dsonar.exclusions=pom.xml \
   -Dsonar.projectKey=training:size-metrics \
   $*

exit $?
