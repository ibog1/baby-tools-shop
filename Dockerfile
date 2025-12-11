# Use official Python base image
FROM python:3.9-slim

# Set working directory inside the container
WORKDIR /app

# Install system dependencies required for Pillow and other packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libjpeg-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency list and install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files into the container
COPY . .

# Expose Django dev server port
EXPOSE 8025

# Run migrations and start the Django development server
CMD ["sh", "-c", "cd babyshop_app && python manage.py migrate && python manage.py runserver 0.0.0.0:8025"]