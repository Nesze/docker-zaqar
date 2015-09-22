#!/bin/sh

sed -i s/MONGO/$1/g zaqar.config

zaqar-server -v --config-file zaqar.config
