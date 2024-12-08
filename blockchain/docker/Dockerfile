FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libtool \
    autotools-dev \
    automake \
    pkg-config \
    libssl-dev \
    libevent-dev \
    bsdmainutils \
    python3 \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-chrono-dev \
    libboost-program-options-dev \
    libboost-test-dev \
    libboost-thread-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /saudichain

# Copy blockchain source
COPY . /saudichain/

# Build the blockchain
RUN cd /saudichain && \
    ./autogen.sh && \
    ./configure --enable-debug --enable-tests && \
    make -j$(nproc)

# Expose ports (testnet)
EXPOSE 18333

# Create data directory
RUN mkdir -p /root/.saudichain

# Add startup script
COPY docker/start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
