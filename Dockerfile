# Use an official Python runtime as a parent image
FROM python:3.11-slim


RUN mkdir /flask

# Copy the current directory contents into the container at /app
COPY /app /flask

# Set the working directory in the container
WORKDIR /flask

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000


# Command to run the Flask app
CMD ["python", "web.py"]