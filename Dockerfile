ARG DEV_PYTHON="3.13.5-slim"
FROM python:${DEV_PYTHON}

# The target platform.
# Some tool installations (like kubectl) need to know whether we're AMD or ARM
# The value will be the platform value used in the build ("linux/amd64" or "linux/arm64")
ARG TARGETPLATFORM
ENV TARGETPLATFORM=${TARGETPLATFORM}

# To fix "unsupported locale"
RUN apt-get update && \
    apt-get install -y locales && \
    echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen && \
    dpkg-reconfigure --frontend=noninteractive locales

ENV LANGUAGE=en_GB.UTF-8
ENV LANG=en_GB.UTF-8
ENV LC_ALL=en_GB.UTF-8

# Install our python requirements, kubectl
ARG KUBECTL_VERSION=1.31.11
COPY requirements.txt /tmp
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        git \
        wget && \
    pip install -r /tmp/requirements.txt && \
    curl -LO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/${TARGETPLATFORM}/kubectl && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl
# Popeye
ARG POPEYE_VERSION=0.22.1
RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        wget https://github.com/derailed/popeye/releases/download/v${POPEYE_VERSION}/popeye_linux_arm64.tar.gz && \
        tar -xf popeye_linux_arm64.tar.gz; \
    elif [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        wget https://github.com/derailed/popeye/releases/download/v${POPEYE_VERSION}/popeye_linux_amd64.tar.gz && \
        tar -xf popeye_linux_arm64.tar.gz; \
    else \
        exit 112; \
    fi && \
    mv popeye /usr/local/bin && \
    rm LICENSE README.md
