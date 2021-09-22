#!/bin/bash

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh | bash && source ~/.bash_profile

nvm install v12.16.8

nvm alias default v12.16.8


