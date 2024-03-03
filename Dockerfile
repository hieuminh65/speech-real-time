FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04

# Set the working directory in the container to /app
WORKDIR /app

RUN apt-get update && apt-get install -y \
    portaudio19-dev \
    python3-pip \
    python3-pyaudio \
    gcc \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Copy only requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

# Install PyTorch with CUDA support and other Python dependencies
RUN pip install torch==2.0.1+cu118 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu118 && \
    pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app

# Make port 9001 available to the outside from this container
EXPOSE 9001

# Run app.py when the container launches
CMD ["python", "./server.py"]
