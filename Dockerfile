ARG BASE_IMAGE=pytorch/pytorch:2.7.0-cuda12.6-cudnn9-runtime
FROM ${BASE_IMAGE}

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ffmpeg \
        git \
        libgl1 \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && pip install -e .

ENV HF_HOME=/cache/hf \
    HUGGINGFACE_HUB_CACHE=/cache/hf \
    TRANSFORMERS_CACHE=/cache/hf

ARG BUILD_HASH=dev
LABEL sam3.build_hash=$BUILD_HASH
