
echo 'checkotu release-candidate'

git checkout release-candidate/0.0.1 -f
git fetch
git pull origin release-candidate/0.0.1 -f

echo 'switch to master'

git checkout master -f
git fetch
git pull origin master -f

echo 'merge release-candidate to master'

git merge origin release-candidate/0.0.1
git push origin master

echo 'todo release process on master branch'

echo 'switch to develop'

git checkout develop -f
git fetch
git pull origin develop -f

echo 'merge master to develop'

git merge origin master
git push origin develop

echo 'release process finished'
