# Use the official Python 3.9 image as the base image for the container.
FROM python:3.9

# Set the working directory inside the container to /code.
WORKDIR /code

# Copy the requirements.txt file from the local machine into the container's /code directory.
# This file lists the Python dependencies required for the FastAPI application.
COPY ./requirements.txt /code/requirements.txt

# Install the Python dependencies listed in the requirements.txt file.
# The "--no-cache-dir" flag ensures that pip doesn't use any cached data during installation.
# The "--upgrade" flag ensures that the latest versions of the dependencies are installed.
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Copy the entire "app" directory from the local machine into the container's /code/app directory.
# This directory contains the main.py file with the FastAPI application code.
COPY ./app /code/app

# Specify the default command to run when the container starts.
# It uses Uvicorn to run the FastAPI application.
# "app.main:app" points to the FastAPI application instance inside the "main.py" file.
# "--host 0.0.0.0" binds the application to all available network interfaces so that it can be accessed externally.
# "--port 80" specifies the port on which the application will listen for incoming requests.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]
