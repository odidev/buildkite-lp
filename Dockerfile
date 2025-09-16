# Use a minimal, deterministic base image
FROM python:3.12-slim

# Set environment variables to prevent Python from writing .pyc files and buffering stdout
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install dependencies separately for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Use a non-root user (optional but recommended for security)
RUN adduser --disabled-password --gecos '' flaskuser
USER flaskuser

# Expose the port Flask will run on
EXPOSE 5000

# Use Flask's CLI for better control; bind to all interfaces
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
