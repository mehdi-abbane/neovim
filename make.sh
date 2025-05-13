#!/usr/bin/env bash
set -e

# Directories
dirs=(
  "cmd/server"
  "config"
  "internal/controllers"
  "internal/models"
  "internal/services"
  "internal/repository"
  "internal/routes"
  "internal/websockets"
  "internal/utils"
  "migrations"
  "templates/layouts"
  "templates/player"
  "templates/admin"
  "static/css"
  "static/js"
  "static/assets"
  "scripts"
)

echo "Creating directories..."
for d in "${dirs[@]}"; do
  mkdir -p "$d"
done

# Files
files=(
  "cmd/server/main.go"
  "config/config.yaml"
  "config/config.go"
  "internal/controllers/player_controller.go"
  "internal/controllers/admin_controller.go"
  "internal/models/player.go"
  "internal/models/item.go"
  "internal/models/event.go"
  "internal/models/drop.go"
  "internal/models/guild.go"
  # add others as needed: zombie.go, base.go, etc.
  "internal/services/game_service.go"
  "internal/services/admin_service.go"
  "internal/services/realtime_service.go"
  "internal/repository/postgres.go"
  "internal/routes/routes.go"
  "internal/websockets/hub.go"
  "internal/websockets/client.go"
  "internal/utils/logger.go"
  "internal/utils/middleware.go"
  "internal/utils/validator.go"
  "migrations/0001_init.up.sql"
  "migrations/0001_init.down.sql"
  "templates/layouts/header.html"
  "templates/layouts/footer.html"
  "templates/player/dashboard.html"
  "templates/player/inventory.html"
  "templates/admin/items.html"
  "templates/admin/events.html"
  "templates/admin/bans.html"
  "static/css/tailwind.css"
  "static/js/alpine.js"
  "static/js/htmx.min.js"
  "scripts/migrate.sh"
  "scripts/seed.sh"
  ".env.example"
  "Dockerfile"
  "docker-compose.yml"
  "Makefile"
  "go.mod"
  "go.sum"
  "README.md"
)

echo "Creating files..."
for f in "${files[@]}"; do
  # create directory if not exists (in case nested)
  mkdir -p "$(dirname "$f")"
  # create empty file if not exists
  [ -f "$f" ] || touch "$f"
done

# Make scripts executable
chmod +x scripts/*.sh

echo "Project structure generated successfully."

