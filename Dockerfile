FROM public.ecr.aws/spacelift/runner-terraform:latest

WORKDIR /tmp

USER root

# Install needed packages including Docker
RUN apk add --no-cache gettext python3 py3-pip docker

# Create and upgrade a Python virtual environment
RUN python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install --upgrade pip \
    && /opt/venv/bin/pip install pyyaml paramiko

# Make the virtual environment available in PATH
ENV PATH="/opt/venv/bin:$PATH"

# Configure SSH for the spacelift user
RUN mkdir -p /home/spacelift/.ssh \
    && chown -R spacelift:spacelift /home/spacelift/.ssh \
    && chmod 700 /home/spacelift/.ssh \
    && echo -e "Host *\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null" > /home/spacelift/.ssh/config \
    && chown spacelift:spacelift /home/spacelift/.ssh/config \
    && chmod 600 /home/spacelift/.ssh/config

# Add the spacelift user to the 'docker' group
RUN addgroup spacelift docker

USER spacelift
