FROM public.ecr.aws/spacelift/runner-terraform:latest

WORKDIR /tmp

USER root

RUN apk add --no-cache gettext python3 py3-pip

RUN python3 -m venv /opt/venv

RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install pyyaml paramiko

ENV PATH="/opt/venv/bin:$PATH"

RUN mkdir -p /home/spacelift/.ssh && \
    chown -R spacelift:spacelift /home/spacelift/.ssh && \
    chmod 700 /home/spacelift/.ssh

RUN echo -e "Host *\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null" > /home/spacelift/.ssh/config && \ 
    chown spacelift:spacelift /home/spacelift/.ssh/config && \ 
    chmod 600 /home/spacelift/.ssh/config

USER spacelift
