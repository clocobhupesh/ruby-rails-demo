# Define the Docker image and container names
APP_NAME := artist-management-system
DB_CONTAINER := $(APP_NAME)_db

# Define the Docker Compose service
SERVICE := web

# Set the default environment
RUBY_VERSION := 3.4.1
RAILS_ENV := development

# Default goal (help)
.DEFAULT_GOAL := help

# Build the Docker images
build:
	docker-compose build 

force-build:
	docker-compose build --no-cache

# Start Docker containers
up:
	docker-compose up 

# Stop Docker containers
down:
	docker-compose down

# Run a command in the Docker container
run:
	docker-compose exec $(SERVICE) bash

# Install dependencies inside the Docker container
install:
	docker-compose run --rm $(SERVICE) bundle install

# Run database migrations inside the Docker container
db-migrate:
	docker-compose run --rm $(SERVICE) bundle exec rake db:migrate

# Seed the database inside the Docker container
db-seed:
	docker-compose run --rm $(SERVICE) bundle exec rake db:seed

# Reset the database inside the Docker container
db-reset:
	docker-compose run --rm $(SERVICE) bundle exec rake db:drop db:create db:migrate db:seed

# Run tests inside the Docker container
test:
	docker-compose exec $(SERVICE) bundle exec rspec

# Generate Swagger documentation using Rswag inside the Docker container
swaggerize:
	docker-compose exec $(SERVICE) bundle exec rake rswag:specs:swaggerize

# Start the Rails server inside the Docker container
server:
	docker-compose exec $(SERVICE) bundle exec rails server

# Run the Rails console inside the Docker container
console:
	docker-compose exec $(SERVICE) bundle exec rails console

# Full task: run tests and generate Swagger docs
full:
	make test
	make swaggerize

# Help task to show available commands
help:
	@echo "Available commands:"
	@echo "  build           Build Docker images"
	@echo "  up              Start Docker containers"
	@echo "  down            Stop Docker containers"
	@echo "  run             Run a command in the Docker container"
	@echo "  install         Install dependencies inside Docker container"
	@echo "  db:migrate      Run database migrations inside Docker container"
	@echo "  db:seed         Seed the database inside Docker container"
	@echo "  db:reset        Reset the database inside Docker container"
	@echo "  test            Run tests inside Docker container"
	@echo "  swaggerize      Generate Swagger documentation inside Docker container"
	@echo "  server          Start Rails server inside Docker container"
	@echo "  console         Run Rails console inside Docker container"
	@echo "  full            Run tests and generate Swagger docs"
