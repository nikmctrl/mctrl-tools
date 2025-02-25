alias f := fmt
alias d := dev


fmt:
  @nix fmt

# Start a development shell with all dependencies
dev:
  @nix develop

# Update all dependencies
update:
  @nix flake update

# Run security checks
security:
#   cmd = "pip-audit"
#   bandit -r .

# Build the project
build:
  @om ci

# Show all available just commands
help:
  @just --list

ci: 
  @om ci default