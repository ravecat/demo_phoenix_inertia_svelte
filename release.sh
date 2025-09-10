#!/bin/bash

# =============================================================================
# DEMO RELEASE SCRIPT - FOR DEMONSTRATION PURPOSES ONLY
# =============================================================================
# This script is created for demonstration and educational purposes.
# For your own use, you may need to modify the environment variables and
# configuration settings to match your specific deployment requirements.
# =============================================================================

set -e  # Exit on any error

echo "🚀 Building production release for demo_phx_sv..."
echo "================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Set production environment
export MIX_ENV=prod

# Check if secret key is provided
if [ -z "$SECRET_KEY_BASE" ]; then
    print_warning "SECRET_KEY_BASE not set. Generating a new one..."
    export SECRET_KEY_BASE=$(mix phx.gen.secret)
    echo "Generated SECRET_KEY_BASE: $SECRET_KEY_BASE"
    echo "Save this key for your production deployment!"
fi

# Set default DATABASE_URL if not provided
if [ -z "$DATABASE_URL" ]; then
    print_warning "DATABASE_URL not set. Setting up local PostgreSQL database."
    export DATABASE_URL="ecto://postgres:postgres@localhost/demo_phx_sv_prod"  # Demo credentials - update for your setup!
    print_status "Using DATABASE_URL: $DATABASE_URL"
    print_warning "Make sure PostgreSQL is running: sudo systemctl start postgresql"
    print_warning "NOTE: Update database credentials for your own deployment!"
fi

# Set default PHX_HOST if not provided
if [ -z "$PHX_HOST" ]; then
    export PHX_HOST="localhost"
fi

# Set default PORT if not provided
if [ -z "$PORT" ]; then
    export PORT=4000
fi

# Set default PORT if not provided
if [ -z "$PORT" ]; then
    export PORT=4000
fi

print_status "Environment variables:"
echo "  MIX_ENV: $MIX_ENV"
echo "  PHX_HOST: $PHX_HOST"
echo "  PORT: $PORT"
echo "  DATABASE_URL: $DATABASE_URL"
echo ""

# Clean previous build
print_status "Cleaning previous builds..."
rm -rf _build/prod
rm -rf deps

# Install dependencies
print_status "Installing dependencies for production..."
mix deps.get --only prod

# Compile the application
print_status "Compiling application..."
mix compile

# Setup database if needed
print_status "Setting up production database..."
print_status "Checking PostgreSQL connection..."

# Try to create database
if mix ecto.create --quiet; then
    print_success "Database created successfully"
elif mix ecto.create 2>&1 | grep -q "already exists"; then
    print_success "Database already exists"
else
    print_error "Failed to create database. Make sure PostgreSQL is running:"
    print_error "  sudo systemctl start postgresql"
    print_error "  sudo -u postgres createuser -s $USER"
    exit 1
fi

# Run migrations
print_status "Running database migrations..."
if mix ecto.migrate --quiet; then
    print_success "Database migrations completed"
else
    print_warning "Migration failed - this may be OK if no migrations exist"
fi

# Build frontend assets
print_status "Building frontend assets (Svelte + Vite)..."
mix assets.deploy

# Create the release
print_status "Creating release..."
mix release --overwrite

# Check if release was successful
if [ -f "_build/prod/rel/demo_phx_sv/bin/demo_phx_sv" ]; then
    print_success "Release created successfully!"
    echo ""
    echo "📦 Release location: _build/prod/rel/demo_phx_sv/"
    echo ""
    echo "🚀 To start the release:"
    echo "  PHX_SERVER=true _build/prod/rel/demo_phx_sv/bin/demo_phx_sv start"
    echo ""
    echo "🌐 To start and access locally:"
    echo "  PHX_SERVER=true _build/prod/rel/demo_phx_sv/bin/demo_phx_sv start"
    echo "  Then open: http://localhost:4000"
    echo ""
    echo "🚀 To start without database (demo mode):"
    echo "  DATABASE_URL=\"ecto://user:pass@localhost/nonexistent\" PHX_SERVER=true _build/prod/rel/demo_phx_sv/bin/demo_phx_sv start"
    echo ""
    echo "🔧 Other commands:"
    echo "  _build/prod/rel/demo_phx_sv/bin/demo_phx_sv daemon    # Start as daemon"
    echo "  _build/prod/rel/demo_phx_sv/bin/demo_phx_sv stop      # Stop the release"
    echo "  _build/prod/rel/demo_phx_sv/bin/demo_phx_sv restart   # Restart the release"
    echo "  _build/prod/rel/demo_phx_sv/bin/demo_phx_sv remote    # Connect to running release"
    echo "  _build/prod/rel/demo_phx_sv/bin/demo_phx_sv pid       # Show process ID"
    echo ""
    echo "📝 Environment variables for production:"
    echo "  export SECRET_KEY_BASE=\"$SECRET_KEY_BASE\""
    echo "  export DATABASE_URL=\"$DATABASE_URL\""
    echo "  export PHX_HOST=\"$PHX_HOST\""
    echo "  export PORT=\"$PORT\""
    echo "  export PHX_SERVER=true"
    echo ""
    print_success "Build completed successfully! 🎉"
    echo ""
    echo "🚀 Quick start command:"
    echo "  ./start_release.sh"
    echo ""
    echo "Or start manually with all variables:"
    echo "  SECRET_KEY_BASE=\"$SECRET_KEY_BASE\" DATABASE_URL=\"$DATABASE_URL\" PHX_SERVER=true _build/prod/rel/demo_phx_sv/bin/demo_phx_sv start"
else
    print_error "Release creation failed!"
    exit 1
fi
