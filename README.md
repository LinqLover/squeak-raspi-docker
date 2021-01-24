# squeak-raspi-docker

Docker files and build scripts for compiling and running the [Squeak/Smalltalk](https://squeak.org/) OSVM on a Raspberry Pi.
Headful access to the running Squeak image is possible using X-Forwarding via SSH.

Customized for Raspi 4B+, but by adjusting the dependency architectures, you should be able to reuse the scripts for a different pi as well.

For some background this repository, you might want to read this thread: [OpenSmalltalk/opensmalltalk-vm#544](https://github.com/OpenSmalltalk/opensmalltalk-vm).
Many thanks to all the helpful hints from the community!
If you have any questions, please create an issue or head to the squeak-vm mailing list!

## Compile it

The `osvm-mvm/build.sh` script will fully-automatically set up a docker container, clone the bleeding-edge version of the [opensmalltalk-vm](https://github.com/OpenSmalltalk/opensmalltalk-vm) repository, and build the `squeak.cog.spur` VM for `build.linux64ARMv8`:

```bash
cd osvm-mvm
./build.sh
```

Temporary build artifacts, including the docker container and image, will automatically be removed on success.

## Execute it

1. Prepare a **VM folder** with the following contents:

   * the VM executable files (see the [compilation guide](#compile-it) from above),
   * a `.sources` file (available at <http://files.squeak.org/sources_files/>).

2. Prepare an **image folder** with the following contents (available at <https://squeak.org/downloads/>):

   * an `.image` file,
   * a `.changes` file.

3. Run the `squeak/build.sh` script, providing the environment variables `SQUEAK_VM_DIR` and `SQUEAK_IMAGE_DIR` pointing to these folders:

   ```bash
   SQUEAK_VM_DIR=<path/to/vm_folder> SQUEAK_IMAGE_DIR=<path/to/image_folder> ./build.sh
   ```

4. Connect to the docker container using X-Forwarding via SHH:

   ```bash
   ssh -X -p 2222 squeak@localhost
   ```

   Inside the container, you can run your Squeak image:

   ```bash
   /bin/squeak/squeak /image/<your_image>.image
   ```

   For unattended operation, you might also want to use `nohup`.
