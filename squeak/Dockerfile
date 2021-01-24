FROM ubuntu:latest

ARG SSH_KEY
ARG SSH_USER=squeak

# Prepare image for ssh [-X] sessions
RUN yes | unminimize
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server x11-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y acl

# Set up non-root user
RUN adduser --disabled-password --gecos '' "${SSH_USER}"
RUN echo X11UseLocalhost no >> /etc/ssh/sshd_config
RUN mkdir /etc/ssh/authorized_keys
RUN echo "${SSH_KEY}" >> "/etc/ssh/authorized_keys/${SSH_USER}"
RUN echo "AuthorizedKeysFile  /etc/ssh/authorized_keys/%u" >> /etc/ssh/sshd_config

# Configure volumes
VOLUME /image
VOLUME /bin/squeak
RUN setfacl -Rm u:"${SSH_USER}":rwx /image
RUN setfacl -Rm u:"${SSH_USER}":rx /bin/squeak

# Enable shared memory for the COG JIT
# See: http://forum.world.st/Sorry-Sorry-WAS-Trouble-running-OSVM-in-an-Ubuntu-20-aarch64-docker-tp5125751.html
# The final mount invocation is in the CMD statement below
RUN chmod 777 /dev/shm
RUN echo "none /dev/shm tmpfs rw,nosuid,nodev 0 0" >> /etc/fstab

# Configure heartbeat thread priority
# See: https://github.com/OpenSmalltalk/opensmalltalk-vm/releases/tag/r3732#linux
# TODO: Find out why this has no effect.
RUN ["/bin/bash", "-c", "cat >> /etc/security/limits.d/squeak.conf <<<$'\
*      hard    rtprio  2 \n\
*      soft    rtprio  2 \n'"]

# Define entrypoint
# The /bin/bash prevents the container from stopping right after starting the service
# Run mount here because we lack the required SYS_ADMIN capapibility earlier
# ⚠ TODO - SECURITY RISK: Unfortunately, this currently forces us to run the entire container stuff in privileged mode ...
CMD mount /dev/shm && \
  # chown: cannot be executed eagerly before folder is mounted
  chown -R "$(ls /home)" /image && \
  service ssh restart && /bin/bash
