#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <service_name>"
    exit 1
fi

SERVICE=$1

# Check if the service is running
if systemctl is-active --quiet "$SERVICE"; then
    echo "The service '$SERVICE' is running."
else
    echo "The service '$SERVICE' is not running."
fi
