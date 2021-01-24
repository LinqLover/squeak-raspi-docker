#!/bin/bash
# Usage:
#   SQUEAK_VM_DIR=<path/to/vm_folder> SQUEAK_IMAGE_DIR=<path/to/image_folder> ./build.sh
#   ssh -X -p 2222 squeak@localhost
# Volume contents:
#   vm_folder: squeak binary [and additional files], SqueakV50.sources
#   image_folder: contains image and changes file
# To clean up again:
#   docker stop squeak && docker rm squeak
set -e

# Build container
export SSH_KEY="${SSH_KEY:-$(< ~/.ssh/id_rsa.pub)}"
SQUEAK_VM_DIR="$(realpath "$SQUEAK_VM_DIR")"
export SQUEAK_VM_DIR
SQUEAK_IMAGE_DIR="$(realpath "$SQUEAK_IMAGE_DIR")"
export SQUEAK_IMAGE_DIR
docker-compose -f squeak/docker-compose.yml up --build -d
