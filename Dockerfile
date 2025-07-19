ARG DEV_PYTHON="3.13.5-slim"
FROM python:${DEV_PYTHON}

# To fix "unsupported locale"
RUN apt-get update && \
    apt-get install -y locales && \
    echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen && \
    echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen && \
    dpkg-reconfigure --frontend=noninteractive locales

ENV LANG=en_GB.UTF-8
ENV LC_ALL=en_GB.UTF-8

# Install other stuff
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git
COPY requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt
