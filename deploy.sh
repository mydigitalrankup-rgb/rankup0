#!/bin/bash

# Glint Hive Deployment Script
# Run this script to prepare your project for deployment

echo "🚀 Starting Glint Hive Deployment Preparation..."

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

# Check if we're in the right directory
if [ ! -f "glinthive/package.json" ] || [ ! -f "backend/package.json" ]; then
    print_error "Please run this script from the project root directory"
    exit 1
fi

print_status "Preparing frontend build..."

# Build frontend
cd glinthive
if [ ! -f "node_modules" ]; then
    print_status "Installing frontend dependencies..."
    npm install
fi

print_status "Building frontend for production..."
npm run build:prod

if [ $? -eq 0 ]; then
    print_success "Frontend build completed successfully!"
else
    print_error "Frontend build failed!"
    exit 1
fi

cd ..

print_status "Preparing backend..."

# Check backend dependencies
cd backend
if [ ! -f "node_modules" ]; then
    print_status "Installing backend dependencies..."
    npm install --production
fi

cd ..

print_status "Creating deployment package..."

# Create deployment directory
mkdir -p deployment
rm -rf deployment/*

# Copy frontend build
cp -r glinthive/dist/* deployment/

# Copy backend
cp -r backend deployment/
rm -rf deployment/backend/node_modules
rm -rf deployment/backend/.env
rm -rf deployment/backend/.env.local

# Copy deployment files
cp DEPLOYMENT_GUIDE.md deployment/
cp backend/env.production.example deployment/backend/.env.example
cp glinthive/env.production.example deployment/.env.production.example

# Create deployment info
cat > deployment/DEPLOYMENT_INFO.txt << EOF
Glint Hive Deployment Package
Generated on: $(date)

Files included:
- Frontend build (dist folder contents)
- Backend source code
- Environment examples
- Deployment guide

Next steps:
1. Upload files to Hostinger
2. Set up MongoDB Atlas
3. Configure environment variables
4. Install backend dependencies
5. Start the application

For detailed instructions, see DEPLOYMENT_GUIDE.md
EOF

print_success "Deployment package created in 'deployment' folder!"

print_warning "IMPORTANT: Before deploying:"
echo "1. Set up MongoDB Atlas database"
echo "2. Update environment variables in backend/.env"
echo "3. Change JWT_SECRET to a secure value"
echo "4. Update CLIENT_ORIGIN to your domain"

print_status "Deployment package ready!"
print_status "Upload the contents of 'deployment' folder to your Hostinger server"

echo ""
print_success "🎉 Deployment preparation completed!"
print_status "Check DEPLOYMENT_GUIDE.md for detailed deployment instructions"
