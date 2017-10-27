#!/bin/bash

for i in `seq 1 20`
do

  curl loadbalance.weave.local/getip >> /var/log/lb_test.log 2> /dev/null
  sleep 1

done

####################
