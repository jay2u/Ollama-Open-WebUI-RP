#!/bin/bash

export PYTHONUNBUFFERED=1

cd /workspace
mkdir -p /workspace/logs /workspace/models

echo "**** Starting Ollama ****"
ollama serve > /workspace/logs/ollama.log 2>&1 &  # Start Ollama and log output

echo "**** Starting Open WebUI ****" && \
open-webui serve &
