FROM nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04


# 
# Python and base tools
# 

# Prevents prompts from packages asking for user input during installation
ENV DEBIAN_FRONTEND=noninteractive
# Prefer binary wheels over source distributions for faster pip installations
ENV PIP_PREFER_BINARY=1
# Ensures output from python is printed immediately to the terminal without buffering
ENV PYTHONUNBUFFERED=1 

RUN <<EOF
    # Install Python, git and other necessary tools
    set -ex
    apt-get update
    apt-get install -y python3.11 python3-pip git wget
    apt-get autoremove -y
    apt-get clean -y && rm -fr /var/lib/apt/lists/*
EOF


# 
# ComfyUI
# 

# Change working directory to ComfyUI
WORKDIR /comfyui

# Clone ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

RUN <<EOF
    # Install ComfyUI dependencies
    set -ex
    pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
    pip3 install --no-cache-dir xformers==0.0.21
    pip3 install -r requirements.txt
EOF

RUN <<EOF
    # Install custom nodes
    set -ex
    FOLDER=./custom_nodes/ComfyUI_IPAdapter_plus
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git 
EOF


# 
# Runpod
# 

# Install runpod
RUN pip3 install runpod requests

# Support for the network volume
ADD src/extra_model_paths.yaml ./

# 
# Start the container
# 

# Go back to the root
WORKDIR /

# Add the start and the handler
ADD src/start.sh src/rp_handler.py test_input.json ./
RUN chmod +x /start.sh
