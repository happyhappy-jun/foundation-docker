FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# Avoid interactive prompts
ARG DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y \
    wget \
    git \
    curl \
    zsh \
    python3-pip \
    python3-dev \
    build-essential \
    vim \
    tmux \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create and set permissions for entrypoint script
RUN echo '#!/bin/zsh\n\
export HOSTNAME=$(curl -s ifconfig.me)\n\
exec "$@"' > /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p /opt/conda \
    && rm /tmp/miniconda.sh

# Add conda to path
ENV PATH=/opt/conda/bin:$PATH

# Install Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Create workspace directory
RUN mkdir -p /workspace

WORKDIR /workspace

# Set ZSH as default shell
SHELL ["/bin/zsh", "-c"]
ENV SHELL=/bin/zsh

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "zsh" ]