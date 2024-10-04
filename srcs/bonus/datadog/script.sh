#!/bin/bash

# Install the Datadog Agent

DD_API_KEY=<datadog_key> \
DD_SITE="us5.datadoghq.com" \
bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Start the Datadog Agent
/etc/init.d/datadog-agent start
