from locust import HttpUser, task, between
import os
import json
import random
from collections import defaultdict


class DynamicLocustTest(HttpUser):
    wait_time = between(0.1, 0.3)  # Default wait time
    tutorial_ids = []  # Used for dynamic endpoint placeholders like {id}
    dynamic_tasks = []
    task_execution_count = defaultdict(int)  # Track the execution count for each task

    def on_start(self):
        """
        Load configuration and initialize before the Locust tasks start.
        """
        # Load host and configuration file from environment variables
        self.host = os.getenv("LOCUST_HOST", "http://google.com")
        config_file = os.getenv("LOCUST_CONFIG_FILE", "config.json")

        # Load configuration dynamically
        try:
            if os.path.exists(config_file):
                with open(config_file, 'r') as f:
                    config = json.load(f)
                    self.dynamic_tasks = config.get("tasks", [])
            else:
                print(f"Configuration file {config_file} not found.")
                self.dynamic_tasks = []
        except json.JSONDecodeError as e:
            print(f"Error decoding JSON from {config_file}: {e}")
            self.dynamic_tasks = []

    def execute_dynamic_task(self, task_config):
        """
        Executes a single dynamic task based on the provided configuration.
        """
        try:
            name = task_config.get("name", "Unnamed Task")
            method = task_config.get("method", "GET").upper()
            endpoint = task_config.get("endpoint", "/")
            body = task_config.get("body", {})
            frequency = task_config.get("frequency", 1)

            # Validate endpoint
            if not endpoint or not isinstance(endpoint, str):
                print(f"Invalid or missing endpoint in task: {task_config}")
                return  # Skip this task

            # Replace placeholders in the endpoint (e.g., {id})
            if "{id}" in endpoint and self.tutorial_ids:
                endpoint = endpoint.replace("{id}", str(random.choice(self.tutorial_ids)))

            # Randomized execution based on frequency
            if random.randint(1, frequency) == 1:
                self.task_execution_count[name] += 1  # Increment task count

                if method == "GET":
                    self.client.get(endpoint)
                elif method == "POST":
                    self.client.post(endpoint, json=body)
                elif method == "PUT":
                    self.client.put(endpoint, json=body)
                elif method == "DELETE":
                    self.client.delete(endpoint)
                else:
                    print(f"Unsupported HTTP method: {method} in task: {task_config}")
        except Exception as e:
            print(f"Error executing task {task_config}: {e}")

    @task
    def execute_dynamic_tasks(self):
        """
        Iterate through all dynamically configured tasks and execute them.
        """
        if not self.dynamic_tasks:
            print("No tasks configured. Skipping execution.")
            return

        for task_config in self.dynamic_tasks:
            self.execute_dynamic_task(task_config)

        # Log total task execution count after the cycle
        print("Task Execution Summary:")
        for task_name, count in self.task_execution_count.items():
            print(f"  {task_name}: {count} executions")

# Command to run Locust with more workers to handle higher RPM:
# locust -f traffic_generator.py --host http://google.com --users 5000 --spawn-rate 1000 --headless --run-time 30m
