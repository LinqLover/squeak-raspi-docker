FROM ubuntu:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y uuid-dev libcairo2-dev libpango1.0-dev libgl1-mesa-dev libgl1-mesa-glx libssl-dev libevdev-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libpulse-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git gcc make

WORKDIR /
RUN git clone https://github.com/OpenSmalltalk/opensmalltalk-vm.git
WORKDIR /opensmalltalk-vm
RUN ./scripts/updateSCCSVersions
