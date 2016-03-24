#!/bin/bash

openssl aes-256-cbc -K $encrypted_bd69831a7c24_key -iv $encrypted_bd69831a7c24_iv -in snapcarttest.pem.enc -out deployment/snapcarttest.pem -d

if [[ $TRAVIS_BRANCH == *"My _VH"* ]]
then
  cap production deploy
fi