#!/bin/bash
set -e
DOCKER=docker

"$DOCKER" build -t osvm-mvm - < mvm-raspbian.dockerfile
"$DOCKER" run -tw /opensmalltalk-vm/build.linux64ARMv8/squeak.cog.spur/build --name=osvm-mvm osvm-mvm sh -c 'yes | head -n1 | ./mvm'
"$DOCKER" cp osvm-mvm:/opensmalltalk-vm/build.linux64ARMv8/squeak.cog.spur/build vm2
"$DOCKER" rm osvm-mvm
"$DOCKER" rmi osvm-mvm
