from flask import Flask, jsonify, send_from_directory
import socket
import os

app = Flask(__name__)

# Function to get the hostname
def get_hostname():
    return socket.gethostname()

# Define the /api/ping endpoint
@app.route('/api/ping', methods=['GET'])
def ping():
    # Get the server's hostname
    hostname = get_hostname()
    
    response = {
        "message": "pong",
        "hostname": hostname
    }
    
    # Return the response as JSON
    return jsonify(response)

# Start the Flask app on port 500
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)