# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.0/containers/python-3/.devcontainer/base.Dockerfile

# [Choice] Python version (use -bullseye variants on local arm64/Apple Silicon): 3, 3.10, 3.9, 3.8, 3.7, 3.6, 3-bullseye, 3.10-bullseye, 3.9-bullseye, 3.8-bullseye, 3.7-bullseye, 3.6-bullseye, 3-buster, 3.10-buster, 3.9-buster, 3.8-buster, 3.7-buster, 3.6-buster
ARG VARIANT="3.10-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}

# Define the path to the virtualenv to work with
ARG VENV_PATH="/home/vscode/venv"

# Copy the requirements file
COPY ./requirements.txt /tmp/pip-tmp/requirements.txt

# Create venv, upgrade pip tooling, then install requirements
RUN su vscode -c 'python -m venv /home/vscode/venv' \
 && su vscode -c '/home/vscode/venv/bin/pip install --upgrade pip setuptools wheel' \
 && su vscode -c '/home/vscode/venv/bin/pip --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt' \
 && rm -rf /tmp/pip-tmp

