#!/bin/bash

# =============================================================================
# DEMO MIGRATION SCRIPT - FOR DEMONSTRATION PURPOSES ONLY
# =============================================================================
# This script is created for demonstration and educational purposes.
# For your own use, you may need to modify the environment variables below
# to match your specific database configuration and security requirements.
# =============================================================================

# Migration script for production release

echo "🔄 Running database migrations for demo_phx_sv..."

# =============================================================================
# ENVIRONMENT VARIABLES - MODIFY FOR YOUR USE CASE
# =============================================================================
# WARNING: These are demonstration values. For your own deployment:
# - Generate a new SECRET_KEY_BASE using: mix phx.gen.secret
# - Use your own database credentials and connection details
# =============================================================================

# Set environment variables
export SECRET_KEY_BASE="uPOi20rKJmM3nUoDoWLZFEr0WC8/8CGPmqFgO8tXH7r0HgDS+roEKsDwF/t23QRj"  # Demo key - generate your own!
export DATABASE_URL="ecto://postgres:postgres@localhost/demo_phx_sv_prod"  # Update with your DB credentials

echo "Database: $DATABASE_URL"
echo ""

# Run migrations using Phoenix release command
_build/prod/rel/demo_phx_sv/bin/migrate

echo ""
echo "✅ Database migrations completed!"
