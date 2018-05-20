#!/bin/bash

_section "Remove old nvidia-docker"
# If you have nvidia-docker 1.0 installed: we need to remove it and all existing GPU containers
docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
sudo apt-get purge -y nvidia-docker
_success "removed old versions"

_section "Get latest nvidia rep"
# Add the package repositories
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
_success "Installed nvidia rep"

_section "Install deps"
# Install nvidia-docker2 and reload the Docker daemon configuration
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
_success "Installed nvidia-docker2"


_section "Edit docker conf"
sudo cp "/etc/docker/daemon.json" "/etc/docker/daemon.json.backup"
sudo tee /etc/docker/daemon.json <<EOF
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    },
    "default-runtime": "nvidia",
    "registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF
sudo pkill -SIGHUP dockerd

#sudo su
#cp "/etc/docker/daemon.json" "/etc/docker/daemon.json.backup"
#sed -i '$ d' "/etc/docker/daemon.json"
#sed -i '${s/$/,/}' /etc/docker/daemon.json
#echo '"registry-mirrors": ["https://registry.docker-cn.com"]' >> "/etc/docker/daemon.json"
#echo '}' >> "/etc/docker/daemon.json"
#exit

cat "/etc/docker/daemon.json"
sudo service docker restart
_success "Changed Docker config"

_section "Run Nvidia/cuda container"
# Test nvidia-smi with the latest official CUDA image
docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
_success "started nvidia/cuda"


_section "Remove install files"
cd .. 
rm -r _nvidia_docker
_success "removed files"
