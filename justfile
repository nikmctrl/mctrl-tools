alias f := fmt
alias d := dev


fmt:
  cmd = "nix fmt"

dev:
  cmd = "nix develop"

# Update all dependencies
update:
  cmd = "nix flake update"

# Run security checks
security:
  cmd = "pip-audit"
  bandit -r .

# Build the project
build:
    nix build

# Show all available just commands
help:
  cmd = "just --list"



ci: 
  om ci 


