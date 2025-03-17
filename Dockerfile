ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Set the shell and enable pipefail for better error handling
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Set basic environment variables
ARG PYTHON_VERSION
ARG TORCH_VERSION
ARG CUDA_VERSION

# Set basic environment variables
ENV SHELL=/bin/bash 
ENV PYTHONUNBUFFERED=True 
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV UV_COMPILE_BYTECODE=1

ENV OLLAMA_HOST=0.0.0.0
ENV OLLAMA_MODELS=/workspace/models
ENV DATA_DIR=/workspace/data
ENV WEBUI_AUTH=False

# Override the default huggingface cache directory.
ENV HF_HOME="/runpod-volume/.cache/huggingface/"

# Faster transfer of models from the hub to the container
ENV HF_HUB_ENABLE_HF_TRANSFER="1"

# Shared python package cache
ENV PIP_CACHE_DIR="/runpod-volume/.cache/pip/"
ENV UV_CACHE_DIR="/runpod-volume/.cache/uv/"

# Set working directory
WORKDIR /

# Install essential packages (optimized to run in one command)
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        git wget curl bash nginx-light rsync sudo binutils nano lshw tzdata build-essential ffmpeg nvtop \
        libgl1 libglib2.0-0 \
        openssh-server ca-certificates && \
    apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install the UV tool from astral-sh
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

# Install Python and create virtual environment
RUN uv python install ${PYTHON_VERSION} --default --preview && \
    uv venv --seed /venv
ENV PATH="/venv/bin:$PATH"

# Install essential Python packages
RUN pip install --no-cache-dir -U \
    pip setuptools wheel \
    jupyterlab jupyterlab_widgets ipykernel ipywidgets \
    open-webui huggingface_hub hf_transfer \
    torch==${TORCH_VERSION} torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/${CUDA_VERSION}

RUN mkdir -p /workspace/{logs,models,data}

# Install Ollama
ADD https://ollama.com/install.sh /ollama-installer.sh
RUN sh /ollama-installer.sh && rm /ollama-installer.sh

# JupyterLab Settings
RUN mkdir -p /root/.jupyter/lab/user-settings/@jupyterlab/{apputils-extension, filebrowser-extension} && \  
    echo '{ "theme": "JupyterLab Dark" }' > /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings && \
    echo '{ "fetchNews": "false" }' > /root/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/notification.jupyterlab-settings && \
    echo '{ "showHiddenFiles": true }' > /root/.jupyter/lab/user-settings/@jupyterlab/filebrowser-extension/browser.jupyterlab-settings

# NGINX Proxy Configuration
COPY proxy/nginx.conf /etc/nginx/nginx.conf
COPY proxy/readme.html /usr/share/nginx/html/readme.html
COPY README.md /usr/share/nginx/html/README.md

# Copy and set execution permissions for start scripts
COPY scripts/start.sh /
COPY scripts/pre_start.sh /
COPY scripts/post_start.sh /
RUN chmod +x /start.sh /pre_start.sh /post_start.sh

# Welcome Message displayed upon login
COPY logo/runpod.txt /etc/runpod.txt
RUN echo 'cat /etc/runpod.txt' >> /root/.bashrc
RUN echo 'echo -e "\nFor detailed documentation and guides, please visit:\n\033[1;34mhttps://docs.runpod.io/\033[0m and \033[1;34mhttps://blog.runpod.io/\033[0m\n\n"' >> /root/.bashrc

# Set entrypoint to the start script
CMD ["/start.sh"]
