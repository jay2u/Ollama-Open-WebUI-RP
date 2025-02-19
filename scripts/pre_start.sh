#!/bin/bash

export PYTHONUNBUFFERED=1

#echo "**** Setting the timezone based on the TIME_ZONE environment variable. If not set, it defaults to Etc/UTC. ****" && \
export TZ=${TIME_ZONE:-"Etc/UTC"} && \
echo "**** Timezone set to $TZ ****" && \
echo "$TZ" | sudo tee /etc/timezone > /dev/null && \
sudo ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime && \
sudo dpkg-reconfigure -f noninteractive tzdata

cd /workspace
mkdir -p /workspace/logs /workspace/models

echo "**** Starting Ollama ****"
ollama serve > /workspace/logs/ollama.log 2>&1 &  # Start Ollama and log output

echo "**** Starting Open WebUI ****" && \
open-webui serve &
