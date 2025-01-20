# Use the official Python base image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the local codebase into the container at the working directory
COPY sb-runner.py requirements.txt ./

# Install system dependencies, Google Chrome, and Python dependencies in one RUN to reduce layers
RUN apt-get update && apt-get install -y wget \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install ./google-chrome-stable_current_amd64.deb -y \
    && pip install --no-cache-dir -r requirements.txt \
    # Clean up unnecessary files and lists to keep the image clean
    && rm -rf /var/lib/apt/lists/* \
    google-chrome-stable_current_amd64.deb

# Run the Python script when the container launches
CMD ["./start-loop.sh"]
