#!/bin/bash

# =============================================================================
# DEMO START SCRIPT - FOR DEMONSTRATION PURPOSES ONLY
# =============================================================================
# This script is created for demonstration and educational purposes.
# For your own use, you may need to modify the environment variables below
# to match your specific configuration and security requirements.
#
# Quick local start script for the production release

echo "🚀 Starting demo_phx_sv production release..."

# =============================================================================
# ENVIRONMENT VARIABLES - MODIFY FOR YOUR USE CASE
# =============================================================================
# WARNING: These are demonstration values. For your own deployment:
# - Generate a new SECRET_KEY_BASE using: mix phx.gen.secret
# - Use your own database credentials and connection details
# - Configure appropriate host and port settings
# - Consider using environment files or secure credential management
# =============================================================================

# Set environment variables
export SECRET_KEY_BASE="uPOi20rKJmM3nUoDoWLZFEr0WC8/8CGPmqFgO8tXH7r0HgDS+roEKsDwF/t23QRj"  # Demo key - generate your own!
export DATABASE_URL="ecto://postgres:postgres@localhost/demo_phx_sv_prod"  # Update with your DB credentials
export PHX_HOST="localhost"  # Change to your domain/IP
export PORT="4000"  # Adjust port as needed
export PHX_URL_SCHEME="http"  # Use "https" in production
export PHX_URL_PORT="4000"  # Match your external port

echo "Environment configured:"
echo "  HOST: $PHX_HOST:$PORT"
echo "  DATABASE: $DATABASE_URL"
echo ""
echo "Starting server... Press Ctrl+C to stop"
echo "Access your app at: http://localhost:4000"
echo ""

# Start the release with Phoenix server
_build/prod/rel/demo_phx_sv/bin/server
