#!/bin/bash

# GetCommunity Docker Compose Management Script
# This script provides convenient commands to manage the Docker Compose environment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

# Check if .env.dev exists
check_env_file() {
    if [ ! -f .env.dev ]; then
        print_error ".env.dev file not found!"
        print_info "Please create a .env.dev file based on .env.example"
        exit 1
    fi
}

# Commands
cmd_start() {
    print_info "Starting GetCommunity services..."
    check_env_file
    docker compose up -d
    print_success "Services started!"
    print_info "Access the application at:"
    echo "  - Frontend:  https://localhost"
    echo "  - Backend:   https://localhost/api"
    echo "  - pgAdmin:   https://localhost/pgadmin"
    echo "  - Traefik:   http://localhost:8080"
}

cmd_stop() {
    print_info "Stopping GetCommunity services..."
    docker compose down
    print_success "Services stopped!"
}

cmd_restart() {
    print_info "Restarting GetCommunity services..."
    docker compose restart
    print_success "Services restarted!"
}

cmd_rebuild() {
    print_info "Rebuilding and restarting services..."
    check_env_file
    docker compose up -d --build
    print_success "Services rebuilt and restarted!"
}

cmd_logs() {
    if [ -z "$1" ]; then
        docker compose logs -f
    else
        docker compose logs -f "$@"
    fi
}

cmd_status() {
    print_info "Service Status:"
    docker compose ps
}

cmd_clean() {
    print_warning "This will stop all services and remove volumes (including database data)!"
    read -p "Are you sure? (yes/no): " -r
    if [[ $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
        print_info "Cleaning up..."
        docker compose down -v
        print_success "Cleanup complete!"
    else
        print_info "Cleanup cancelled."
    fi
}

cmd_exec() {
    if [ -z "$1" ]; then
        print_error "Please specify a service name (backend, frontend, postgres)"
        exit 1
    fi
    
    service=$1
    shift
    
    if [ -z "$1" ]; then
        docker compose exec "$service" sh
    else
        docker compose exec "$service" "$@"
    fi
}

cmd_db_reset() {
    print_warning "This will reset the database (all data will be lost)!"
    read -p "Are you sure? (yes/no): " -r
    if [[ $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
        print_info "Resetting database..."
        docker compose stop postgres
        docker volume rm getcommunity_gc-www-db-data || true
        docker compose up -d postgres
        print_success "Database reset complete!"
    else
        print_info "Database reset cancelled."
    fi
}

cmd_help() {
    echo "GetCommunity Docker Compose Management"
    echo ""
    echo "Usage: ./docker.sh [command] [options]"
    echo ""
    echo "Commands:"
    echo "  start           Start all services"
    echo "  stop            Stop all services"
    echo "  restart         Restart all services"
    echo "  rebuild         Rebuild and restart services"
    echo "  logs [service]  View logs (optionally for specific service)"
    echo "  status          Show service status"
    echo "  clean           Stop services and remove volumes"
    echo "  exec <service>  Execute command in service container"
    echo "  db-reset        Reset the database"
    echo "  help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  ./docker.sh start"
    echo "  ./docker.sh logs backend"
    echo "  ./docker.sh exec backend npm run strapi"
    echo "  ./docker.sh rebuild"
}

# Main script
case "$1" in
    start)
        cmd_start
        ;;
    stop)
        cmd_stop
        ;;
    restart)
        cmd_restart
        ;;
    rebuild)
        cmd_rebuild
        ;;
    logs)
        shift
        cmd_logs "$@"
        ;;
    status)
        cmd_status
        ;;
    clean)
        cmd_clean
        ;;
    exec)
        shift
        cmd_exec "$@"
        ;;
    db-reset)
        cmd_db_reset
        ;;
    help|--help|-h|"")
        cmd_help
        ;;
    *)
        print_error "Unknown command: $1"
        cmd_help
        exit 1
        ;;
esac
