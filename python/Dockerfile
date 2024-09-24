FROM python:3.11-slim

# Install required packages
RUN pip install locust

# Copy your locustfile.py into the container
COPY traffic_generator.py /locustfile.py

# Set environment variables
#ENV LOCUST_HOST=http://how2web.default.svc.cluster.local

# Command to run Locust
CMD ["locust", "-f", "/locustfile.py", "--headless", "-u", "500000", "-r", "100", "--run-time", "30m"]
