# Use official Python base image
FROM python:3.9-slim

# Set working directory inside the container
WORKDIR /app


# Copy dependency list and install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files into the container
COPY . .

# Expose Django dev server port
EXPOSE 8025

# Run migrations and start the Django development server
CMD ["sh", "-c", "cd babyshop_app && python manage.py migrate && python manage.py runserver 0.0.0.0:8025"]