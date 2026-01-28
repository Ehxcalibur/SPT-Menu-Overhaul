#!/bin/bash
set -e

# Initialize if needed
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
    git branch -m main
fi

# Ensure correct remote
if git remote | grep -q "^origin$"; then
    git remote set-url origin https://github.com/Ehxcalibur/SPT-Menu-Overhaul.git
else
    git remote add origin https://github.com/Ehxcalibur/SPT-Menu-Overhaul.git
fi

# Configure identity if missing
if [ -z "$(git config user.email)" ]; then
    echo "Git identity not detected."
    echo "Please enter your details to configure git for this repository."
    read -p "Enter your email: " email
    git config user.email "$email"
    
    read -p "Enter your name: " name
    git config user.name "$name"
fi

# Add and Commit
echo "Staging files..."
git add .

echo "Committing changes..."
# Allow empty commit if nothing changed (re-running script)
git commit -m "Update for SPT 4.0.11: Fix missing buttons and update project refs" || echo "No changes to commit or already committed."

# Push
echo "Pushing to GitHub..."
echo "You will be asked for your GitHub credentials."
git push -u origin main --force
