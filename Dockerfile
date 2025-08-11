# Dockerfile

# --- Stage 1: Build Stage (for dependencies) ---
# Using a slim-buster image for a smaller footprint.
FROM python:3.11-slim-bullseye AS build_stage

# Set the working directory inside the container
WORKDIR /app

# Prevent Python from writing .pyc files and buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies needed for some Python packages (e.g., torch)
# This step is crucial for many deep learning libraries that rely on native C/C++ extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl \
    # Add any other system packages your specific requirements might need, e.g.,
    # libgl1-mesa-glx # if you were doing image processing with OpenCV
    # git # if you have direct git dependencies in requirements.txt
    && rm -rf /var/lib/apt/lists/*

# Copy only the requirements file first to leverage Docker caching.
# If requirements.txt doesn't change, Docker won't re-run pip install.
COPY requirements.txt .

# Install Python dependencies
# --no-cache-dir reduces image size by not storing pip's cache
# --upgrade ensures packages are upgraded if already present
# Using a specific index (like pypi.org) can be helpful in some environments
RUN pip install --no-cache-dir --upgrade -r requirements.txt


# --- Stage 2: Production Stage (smaller, only includes runtime necessities) ---
# Use a smaller base image for the final runtime image
FROM python:3.11-slim-bullseye

# Set the working directory
WORKDIR /app

# Copy installed packages from the build stage
COPY --from=build_stage /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=build_stage /usr/local/bin /usr/local/bin

# Copy the application code
COPY . .

# Expose the port FastAPI will run on
EXPOSE 8000

# Command to run the application using Uvicorn
# Using the exec form `["uvicorn", ...]` is generally preferred for proper signal handling.
# `0.0.0.0` binds to all available network interfaces, making the API accessible from outside the container.
# `main:app` refers to the `app` object in `main.py`.
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]