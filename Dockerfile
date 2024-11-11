# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire current directory into the container
COPY . .

# Expose port 8080 to match Cloud Run's default port
EXPOSE 8080

# Set environment variable for Gunicorn
ENV PYTHONUNBUFFERED=1
ENV PORT=8080

# Run Gunicorn to serve the app with specified options
CMD ["gunicorn", "--bind", ":$PORT", "--workers", "1", "--threads", "8", "--timeout", "0", "main:app"]
