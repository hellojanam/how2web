# Use a minimal base Python image
FROM python:3.11-slim

# Set a working directory
WORKDIR /app

# Install Locust
RUN pip install --no-cache-dir locust

# Copy the Locust file into the container
COPY traffic_generator.py /app/locustfile.py

# Default command to run Locust
CMD ["sh", "-c", "locust -f /app/locustfile.py --headless -u $LOCUST_USERS -r $LOCUST_SPAWN_RATE --run-time $LOCUST_RUN_TIME --host $LOCUST_HOST"]
