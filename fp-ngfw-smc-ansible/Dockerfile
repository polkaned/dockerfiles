
# Run Ansible modules for configuration and automation of Forcepoint NGFW Next Generation Firewall in a container

FROM debian:bullseye-slim
LABEL maintainer "benjamin@polkaned.net"

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        python3-setuptools \
        python3-wheel \
        python3-pip \
        git \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install ansible

RUN cd /tmp \
    && git clone https://github.com/Forcepoint/fp-NGFW-SMC-python.git \
    && cd fp-NGFW-SMC-python \
    && python3 setup.py install

RUN cd /tmp \
    && git clone https://github.com/Forcepoint/fp-NGFW-SMC-ansible.git \
    && cd fp-NGFW-SMC-ansible \
    && python3 install.py

COPY entrypoint.sh /tmp/entrypoint.sh

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]
