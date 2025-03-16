#!/bin/bash

echo "**** Starting Ollama ****"
ollama serve > /workspace/logs/ollama.log 2>&1 &  # Start Ollama and log output

echo "**** Starting Open WebUI ****" && \
open-webui serve &
