# ---- Builder stage ----
FROM ubuntu:22.04 AS builder

# Install build dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git build-essential autoconf cmake libglu1-mesa-dev libgtk-3-dev \
    libdbus-1-dev libwebkit2gtk-4.1-dev texinfo libtool locales time \
    curl ca-certificates && \
    apt-get clean

# Add these lines:
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

WORKDIR /app

# Clone PrusaSlicer
RUN git clone https://github.com/prusa3d/PrusaSlicer.git

WORKDIR /app/PrusaSlicer

# Build dependencies and PrusaSlicer
RUN set -e && \
    cd deps && \
    mkdir -p build && cd build && \
    cmake .. -DDEP_WX_GTK3=ON && \
    make && \
    cd ../.. && \
    mkdir -p build && cd build && \
    cmake .. -DSLIC3R_STATIC=1 -DSLIC3R_GTK=3 -DSLIC3R_PCH=OFF -DCMAKE_PREFIX_PATH=$(pwd)/../deps/build/destdir/usr/local && \
    make -j4

# ---- Runtime stage ----
FROM ubuntu:22.04

# Install runtime dependencies only (no build tools), but keep libwebkit2gtk-4.1-dev as requested
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libglu1-mesa \
    libgtk-3-0 \
    libdbus-1-3 \
    libwebkit2gtk-4.1-dev \
    locales \
    time \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy PrusaSlicer CLI binary and resources from builder
COPY --from=builder /app/PrusaSlicer/build/src/prusa-slicer /app/prusa-slicer
COPY --from=builder /app/PrusaSlicer/resources /app/resources

ENTRYPOINT ["/bin/bash"]