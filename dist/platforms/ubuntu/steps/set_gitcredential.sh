#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install git -y
git --version 

if [ -z "${GIT_PRIVATE_TOKEN}" ]
then
  echo "GIT_PRIVATE_TOKEN unset skipping"
else
  echo "GIT_PRIVATE_TOKEN is set configuring git credentials"

	git config --global credential.helper store
	git config --global --replace-all url."https://token:$GIT_PRIVATE_TOKEN@github.com/".insteadOf ssh://git@github.com/
	git config --global --add url."https://token:$GIT_PRIVATE_TOKEN@github.com/".insteadOf git@github.com

  git config --global --add url."https://token:$GIT_PRIVATE_TOKEN@github.com/".insteadOf "https://github.com/"
  git config --global url."https://ssh:$GIT_PRIVATE_TOKEN@github.com/".insteadOf "ssh://git@github.com/"
  git config --global url."https://git:$GIT_PRIVATE_TOKEN@github.com/".insteadOf "git@github.com:"
fi
git version
echo "---------- git config --global --add safe.directory -------------"
git config --global --replace-all safe.directory '*'
git config --global --add "safe.directory" "*"
git config --global --add "safe.directory" "/github/workspace"
git config --global --add "safe.directory" "/github/workspace/*"
git config --global --get-all "safe.directory"
git config --replace-all safe.directory '*'
git config --add "safe.directory" "*"
git config --add "safe.directory" "/github/workspace"
git config --add "safe.directory" "/github/workspace/*"

echo "---------- git config --list -------------"
git config --list

echo "---------- git config --list --show-origin -------------"
git config --list --show-origin

