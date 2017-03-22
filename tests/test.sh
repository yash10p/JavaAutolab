#!/bin/bash

jshint main_server/main_server.js || echo "=======jslint failure on mainserver========="
eslint main_server/main_server.js || echo "=======eslint failure on mainserver========="

jshint load_balancer/load_balancer.js || echo "=======jslint failure on loadbalancer========="
eslint load_balancer/load_balancer.js || echo "=======eslint failure on loadbalancer========="

jshint execution_nodes/execute_node.js || echo "=======jslint failure on executionnode========="
eslint execution_nodes/execute_node.js || echo "=======eslint failure on executionnode========="

grep -rl --exclude-dir=node_modules '/etc' .. | xargs sed -i 's/\/etc/\.\.\/deploy\/configs/g'
mv execution_nodes/extract_run_test.sh ../execution_nodes/extract_run.sh

cd main_server
chmod +x main_server.js
npm install
node main_server.js&
sleep 20

cd ../load_balancer
chmod +x load_balancer.js
npm install
node load_balancer.js&
sleep 20

cd ../execution_nodes
chmod +x execute_node.js
npm install
node execute_node.js&
sleep 20

curl --ipv4 -k https://127.0.0.1:9000

cd tests
chmod +x submit.js

npm install minimist
npm install cli-table
npm install socket.io-client
node submit.js -i 2015A7PS006G -l labtest&
sleep 20


