#!/usr/bin/env bash
set -ex

cd /runpod-volume/models-ipadapter/
mkdir -p {checkpoints,vae,ipadapter,clip_vision,controlnet}

wget 'https://civitai.com/api/download/models/308455?type=Model&format=SafeTensor&size=full&fp=bf16&token=50f87f8cb2fda11456aa7bb2346295fb' \
    -c -N -O checkpoints/wildcardxXL_v4Rundiffusion.safetensors
wget https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors \
    -c -N -O vae/sdxl_vae.safetensors 
wget https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors \
    -c -N -O vae/sdxl-vae-fp16-fix.safetensors 

# ipadapter
wget https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors \
    -c -N -O ipadapter/ip-adapter-plus_sdxl_vit-h.safetensors
wget https://huggingface.co/h94/IP-Adapter/resolve/main/models/image_encoder/model.safetensors \
    -c -N -O clip_vision/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors 
wget https://huggingface.co/xinsir/controlnet-scribble-sdxl-1.0/resolve/main/diffusion_pytorch_model.safetensors \
    -c -N -O controlnet/controlnet-scribble-sdxl-1.0.safetensors 