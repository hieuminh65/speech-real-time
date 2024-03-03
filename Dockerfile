# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory in the container to /app
WORKDIR /app

RUN apt-get update && apt-get install -y portaudio19-dev python3-pyaudio gcc gcc+

# Copy only requirements.txt first to leverage Docker cache
COPY ./requirements.txt /app/requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app
COPY . /app

# Make port 9001 available to the outside from this container
EXPOSE 9001

# Define environment variable
ENV NAME App

# Run app.py when the container launches
CMD ["python", "./server.py"]
