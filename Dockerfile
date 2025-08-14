# project/Dockerfile
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Add a non-root user
RUN adduser --disabled-password --gecos "" appuser
USER appuser

WORKDIR /app

# Install Python deps first (better caching)
COPY --chown=appuser:appuser requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Add your parser
COPY --chown=appuser:appuser truist_to_csv.py /app/

# Default entrypoint: run the parser script
ENTRYPOINT ["python", "/app/truist_to_csv.py"]

