# Use the official Python base image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the local codebase into the container at the working directory
COPY sb-runner.py requirements.txt ./

# Install system dependencies and Google Chrome separately
RUN apt-get update && apt-get install -y wget

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

RUN apt install -y ./google-chrome-stable_current_amd64.deb && rm -f google-chrome-stable_current_amd64.deb

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Clean up APT cache to reduce image size
RUN rm -rf /var/lib/apt/lists/*

# Run the Python script when the container launches
CMD ["./entrypoint.sh"]
