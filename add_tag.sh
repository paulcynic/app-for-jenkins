#!/bin/bash -e

TEST_TAG=$(git describe --contains `git rev-parse HEAD`) || true

if [ -z "$TEST_TAG" ] ; then
    TAG=$(git tag | sort -V | tail -1)
    NEXT_TAG=$(echo ${TAG} | awk -F. -v OFS=. '{$NF += 1 ; print}')
    git tag $NEXT_TAG
    git branch $(echo ${NEXT_TAG} | awk -F. -v OFS=. '{$NF += 1 ; print}')-rc${NEXT_TAG:0-1}
fi

echo $(git tag)
echo $(git branch -a)
