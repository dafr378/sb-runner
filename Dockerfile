# Use the official Python base image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the local codebase into the container at the working directory
COPY sb-runner.py requirements.txt ./

# Install necessary packages and add Google's official repository
RUN apt-get update && \
    apt-get install -y wget gnupg --no-install-recommends && \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && \
    apt-get install -y google-chrome-stable --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Ensure the entrypoint script is executable
RUN chmod +x sb-runner.py

# Run the Python script when the container launches
CMD ["./sb-runner.py"]
