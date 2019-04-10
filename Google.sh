#!/bin/bash
python_environment=$(locate -n 1 /env/bin/activate)

source $python_environment
google-assistant-demo

source config.sh
source $python_environment
google-assistant-demo --project-id $project_id --device-model-id $device_model_id
