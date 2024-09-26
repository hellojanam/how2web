from locust import HttpUser, task, between
import os
import random

class MyLocustTest(HttpUser):
    wait_time = between(0.1, 0.3)  # Reduced wait time to generate more traffic
    tutorial_ids = []

    def on_start(self):
        self.host = os.getenv("LOCUST_HOST", "http://localhost:8080")

    @task(3)  # More frequent creation of tutorials
    def create_tutorial(self):
        response = self.client.post("/api/tutorials", json={
            "title": f"Test Tutorial {random.randint(1, 10000)}",
            "description": "Test Description",
            "published": True
        })
        if response.status_code == 201:
            # Store the created tutorial ID for future operations
            new_tutorial = response.json()
            self.tutorial_ids.append(new_tutorial['id'])

    @task(4)  # Increase frequency of reading tutorials
    def get_tutorial_by_id(self):
        if self.tutorial_ids:
            tutorial_id = random.choice(self.tutorial_ids)
            self.client.get(f"/api/tutorials/{tutorial_id}")

    @task(3)  # Frequent update tasks
    def update_tutorial(self):
        if self.tutorial_ids:
            tutorial_id = random.choice(self.tutorial_ids)
            self.client.put(f"/api/tutorials/{tutorial_id}", json={
                "title": f"Updated Tutorial {random.randint(1, 10000)}",
                "description": "Updated Description",
                "published": True
            })

    @task(2)  # Get all tutorials task to vary the load
    def get_all_tutorials(self):
        self.client.get("/api/tutorials")

    @task(2)  # Get all published tutorials
    def get_published_tutorials(self):
        self.client.get("/api/tutorials/published")

    @task(3)  # Task to periodically delete tutorials
    def delete_tutorial(self):
        if self.tutorial_ids:
            tutorial_id = random.choice(self.tutorial_ids)
            response = self.client.delete(f"/api/tutorials/{tutorial_id}")
            if response.status_code == 200 or response.status_code == 204:
                # Remove the ID from the list after successful deletion
                self.tutorial_ids.remove(tutorial_id)

# Command to run Locust with more workers to handle higher RPM:
# locust -f mylocustfile.py --host http://target-url.com --users 5000 --spawn-rate 1000 --headless --run-time 30m
