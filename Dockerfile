FROM public.ecr.aws/spacelift/runner-terraform:latest

WORKDIR /tmp

USER root

RUN apk add --no-cache gettext python3 py3-pip

RUN python3 -m venv /opt/venv

RUN /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install pyyaml paramiko

ENV PATH="/opt/venv/bin:$PATH"

USER spacelift
