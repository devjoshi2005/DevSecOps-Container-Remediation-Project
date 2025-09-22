FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies (if needed)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# Copy dependency list and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ ./app

# Expose Flask port
EXPOSE 8080

# Set environment variables
ENV FLASK_APP=app/main.py \
    FLASK_RUN_HOST=0.0.0.0 \
    FLASK_RUN_PORT=8080

# Run the Flask app
CMD ["flask", "run"]
