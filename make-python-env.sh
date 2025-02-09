#!/bin/bash
# Author: Vipul Ramtekkar
# Date: 2025-02-09

set -e  # Exit immediately if a command exits with a non-zero status

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "Creating Python environment..."

# Install uv if not installed
if ! command_exists uv; then
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    echo "uv is already installed."
fi

# Initialize uv project
uv init

# Install dependencies
uv add --dev ruff mypy pre-commit

echo "Configuring pre-commit hooks..."

# Create pre-commit config file
cat > .pre-commit-config.yaml <<EOL
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.0  # Use the latest stable version
    hooks:
      - id: ruff
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.8.0  # Use the latest stable version
    hooks:
      - id: mypy
EOL

# Install pre-commit hooks
pre-commit install

echo "Setup complete!"

