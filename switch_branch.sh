#!/bin/sh -l

cd $1
echo "switching branch..."
git checkout $2 > /dev/null 2>&1 || true
echo "(new) active branch for $1:"
git branch | grep \* | cut -d ' ' -f2
cd ..