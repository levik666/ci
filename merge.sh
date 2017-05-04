#!/bin/sh
# source the properties:
. gradle.properties

# Then reference then:
echo "version is $version and prevTag is $prevTag and nextTag is $nextTag-SNAPSHOT"

function string_replace {
    echo "${1/\-/$2}"
}

$version=$(string_replace "$version" "SNAPSHOT")

if [ $version != $prevTag ]; then
    echo "version is $version   should be equels with prevTag is $prevTag"
    return -1;
fi

ls -la && echo 'checkout release-candidate' && git checkout release-candidate/0.0.1 -f && git fetch && git pull origin release-candidate/0.0.1 -f &&
echo 'switch to master' && git checkout master -f && git fetch && git pull origin master -f && 
echo 'merge release-candidate to master' && git merge origin release-candidate/0.0.1 && git push origin master && 
echo 'todo release process on master branch' && ./gradlew :release -Prelease.useAutomaticVersion=true -Prelease.releaseVersion=0.10.16 -Prelease.newVersion=0.10.17-SNAPSHOT && 
echo 'switch to develop' && git checkout develop -f && git fetch && git pull origin develop -f && 
echo 'merge master to develop' && git merge origin master && git push origin develop &&
echo 'release process finished'

