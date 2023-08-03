#!/bin/bash

# Start Nginx server
nginx -g 'daemon off;' &

# Run the watch.sh script from the correct path
/usr/local/bin/watch.sh
