FROM ubuntu:20.04

ARG OPENAI_API_KEY

ENV OPENAI_API_KEY=${OPENAI_API_KEY}
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y \
    g++ \
    cmake \
    libxml2-dev \
    qt5-default \
    libqwt-qt5-dev \
    libopenscenegraph-dev \
    libbullet-dev \
    python3-pip \
    python3-venv \
    git \
    libasio-dev \
    libzmq3-dev \
    libgl1-mesa-glx \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone and set up the repository
RUN git clone https://github.com/HRI-EU/AttentiveSupport.git /app/AttentiveSupport && \
    cd /app/AttentiveSupport && git submodule update --init --recursive

WORKDIR /app/AttentiveSupport
RUN mkdir -p build && cd build && rm -rf && cmake ../src/Smile/ -DCMAKE_INSTALL_PREFIX=../install && make -j$(nproc) && make install

RUN pip install --upgrade pip && \
    pip install -r /app/AttentiveSupport/requirements.txt

RUN apt-get update & \
    apt-get upgrade

CMD ["/bin/bash"]
