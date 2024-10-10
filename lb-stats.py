import requests
import json
from collections import defaultdict

# Variables
url = "https://ev4o.com/api/ping"
num_requests = 10
hostnames = defaultdict(int)

# Send requests and collect responses
for i in range(1, num_requests + 1):
    print(f"Sending request #{i}...")
    try:
        response = requests.get(url)
        response.raise_for_status()  # Ensure we catch any HTTP errors
        data = response.json()
        hostname = data.get("hostname", None)

        if hostname:
            hostnames[hostname] += 1
            print(f"Raw response: {json.dumps(data)}")
        else:
            print(f"Warning: Empty or invalid response for request #{i}")
    except requests.exceptions.RequestException as e:
        print(f"Error during request #{i}: {e}")

# Summarize the results
print("\n=== Request Summary ===")
print(f"Total requests: {num_requests}")
print(f"Count of available nodes: {len(hostnames)}")

for hostname, count in hostnames.items():
    print(f"Hostname: {hostname}, Requests handled: {count}")