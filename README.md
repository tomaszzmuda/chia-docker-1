# Chia Docker

A set of Dockerfiles to run chia plotters and a farmer inside a container, with all dependencies already available.

## Prerequisites

For this setup, I assume that you have a single directory for storing plots, in this guide this path is shown as `/plot-storage`. Make sure this path is replaced with the actual location that your storage drives are mounted on. Only one directory is supported - you should be using some kind of RAID/drive pooling setup. [ZFS](https://openzfs.github.io/openzfs-docs/Getting%20Started/index.html) is highly recommended, and can pool drives together to make one big volume.

A second drive is also indicated as `/scratch` - this is where the plotters will generate their plots. This should be a single fast (preferably NVMe) SSD.

The database for the farmer will be persisted in a Docker volume - this is relatively small, and will just be stored on your boot drive.

## Setup

### Generating a keyfile

1. Create a blank file in farmer named keyfile: `touch farmer/keyfile`
2. Build the genkey image: `docker build -t localhost/chia-genkey farmer/`
3. Run command: `docker run --rm localhost/chia-genkey bash -c 'chia init && chia keys generate_and_print' | sed -n '7p' > keyfile`. Copy the keyfile to both the plotter and farmer directories.
4. Delete the genkey image, as it's only ever needed once: `docker image rm localhost/chia-genkey:latest`

Your keyfile should now have a newly generated key in it. **IMPORTANT: keep this key safe. It will also be embedded in your docker containers, so don't publish or share these containers publicly.**

### Starting the farmer

It can take a while for the farmer to sync, so start this before you start plotting. This container needs 2 volumes: one for the farmer database, and one shared volume where the plots are stored.

1. Build the farmer image: `docker build -t localhost/chia-farmer farmer/`
2. Create a docker volume for the database: `docker volume create chia-db`
3. Run this command to start the farmer: `docker run -it -p 8444:8444 --name farmer -v chia-db:/root/.chia -v /plot-storage:/plots:ro localhost/chia-farmer`
4. Port forward port 8444 in your router to your server.

The farmer will start up, import the keyfile to its keychain and then delete the original keyfile within the container. It will then start the farmer daemon and run a check of all your plots. You can type `CTRL+P CTRL+Q` to detach yourself from the container and leave it running in the background.

The plots directory is mounted as read-only, for safety.

### Starting a plotter

Multiple containers of the plotter can be run in parallel. It's recommended to stagger the start times to improve efficiency. Each container will keep generating new plots for as long as it's running, and also has an useful killswitch so you can instruct the container to exit once it finishes its next plot.

1. Build the plotter image: `docker build -t localhost/chia-plotter plotter/`
2. Start the plotter with `docker run -d --name plotter1 -v /scratch/plotter1:/tmp -v /storage/chia:/plots localhost/chia-plotter`
3. Repeat, each time with plotter2, plotter3 etc.

**IMPORTANT**: Do not use the same /tmp directory for every plotter. On startup, the plotter will delete all temporary files it sees in this folder, to cleanup from potential failed previous runs. In the above example, the /tmp folder is given a subdirectory on the scratch drive.

Alternatively, use the start-plotter bash script to start x number of plotters: `nohup bash start-plotters.sh 4 &`. Modify the script to point to the correct storage volumes first. Replace the number 4 with the number of plotters you want to start. This script will run in the background, and start each plotter every 2 hours. This staggers the start time of each plotter to maximise efficiency.

If at any time you want to stop a plotter, but don't want to lose the current plot, run this command: `docker exec plotter1 touch /root/stoprun`. Once the container finishes its current plot, it will exit instead of starting another.

## How to use

If you're following this guide I assume that you already have a good knowledge of how to manage docker, but here's a few pointers:

- Try not to attach yourself directly to the running containers. One wrong keystroke and you can accidentally terminate your plotter. Instead use `docker logs -tf plotter1` to get a live updated view of the logs, that you can view and `CTRL+C` to your heart's content.
- To check the status of your farmer, run `docker exec -it farmer bash`. This will open a new shell where you can type commands such as `chia show -sc` and `chia wallet show` without disturbing the running node.
- Viewing the logs of the farmer will give you an hourly update on the status of the node, along with your wallet balance.

## Upgrading

### Farmer

To upgrade the farmer node, it should be as simple as deleting the current running container with `docker rm -f farmer`, building the farmer container again and starting it. On startup, the container will perform any migrations necessary to the database stored in the docker volume.

If for some reason your database is corrupt, deleting the chia-db volume and creating it again will force it to make a new database.

### Plotter

Plotters are stateless, and can be deleted at any time. Stop the plotter gracefully with `docker exec plotter1 touch /root/stoprun`, wait for the current plot to finish, then delete the container. Rebuild the plotter image and start it again.
