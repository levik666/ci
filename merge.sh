#!/bin/sh
# source the properties:
. gradle.properties

# Then reference then:
echo "version is $version and prevTag is $prevTag and nextTag is $nextTag-SNAPSHOT"

function string_replace() {
    printf $version | sed 's/-SNAPSHOT$//'
}

version_updated=$(string_replace "$version")

if [ "$version_updated" == "$prevTag" ]; then
		# Release process:
		pwd && ls -la && 
		echo 'checkout release-candidate' && git checkout release-candidate/${version_updated} -f && git fetch && git pull origin release-candidate/${version_updated} -f &&
		echo 'switch to master' && git checkout master -f && git fetch && git pull origin master -f && 
		echo 'merge release-candidate to master' && git merge origin release-candidate/${version_updated} && git push origin master && 
		echo 'todo release process on master branch' && ./gradlew :release -Prelease.useAutomaticVersion=true -Prelease.releaseVersion=${prevTag} -Prelease.newVersion=$nextTag-SNAPSHOT  && 
		echo 'switch to develop' && git checkout develop -f && git fetch && git pull origin develop -f && 
		echo 'merge master to develop' && git merge origin master && git push origin develop &&
		echo 'release process finished'
    else 
    	echo "version is $version_updated should be equels with prevTag is $prevTag"
fi
