#!/bin/bash
while [ true ]
do

        pro=$(ps -ef | grep "node /usr/share/yarn/bin/yarn.js start" | grep -v grep | grep -v "$0")
        if [ -z "$pro" ]
        then 
                nohup yarn start  >> kyve.log &   
        else
                  echo "succesful"
        fi
        
        sleep 10

done
