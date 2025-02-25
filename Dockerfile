# Use the latest Ubuntu image
FROM ubuntu:latest

# Set environment variables to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt update && apt install -y python3 python3-pip python3-venv

# Set the working directory
WORKDIR /app

# Copy the application files
COPY . /app

# Create a virtual environment and install dependencies
RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Expose the FastAPI port
EXPOSE 8000

# Ensure the container keeps running with Uvicorn
CMD ["venv/bin/python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
