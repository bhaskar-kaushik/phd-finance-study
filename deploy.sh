#!/bin/bash
# Run this script from inside the phd-finance-study folder to set up the GitHub repo and deploy to Pages.
# Prerequisites: git and gh (GitHub CLI) installed and authenticated.

set -e

REPO_NAME="phd-finance-study"

echo "=== Setting up GitHub repo: $REPO_NAME ==="

# Initialize git repo
git init
git add index.html README.md
git commit -m "Initial commit: PhD Finance Study Platform

158 papers across 5 courses (Corp Finance I & II, Banking, Risk Management, Asset Pricing)
113 essay questions with model answers
Mock exam simulation, synthesis flashcards, study planner
Single-file HTML, no dependencies"

# Create GitHub repo (public, for Pages)
gh repo create "$REPO_NAME" --public --source=. --push

# Enable GitHub Pages from main branch
gh api -X PUT "repos/$(gh api user -q .login)/$REPO_NAME/pages" \
  -f "build_type=workflow" \
  -f "source[branch]=main" \
  -f "source[path]=/" 2>/dev/null || \
gh api -X POST "repos/$(gh api user -q .login)/$REPO_NAME/pages" \
  -f "build_type=legacy" \
  -f "source[branch]=main" \
  -f "source[path]=/" 2>/dev/null || \
echo "Note: You may need to enable Pages manually in repo Settings > Pages > Source: main branch"

USERNAME=$(gh api user -q .login)
echo ""
echo "=== Done! ==="
echo "Repo: https://github.com/$USERNAME/$REPO_NAME"
echo "Site: https://$USERNAME.github.io/$REPO_NAME/"
echo ""
echo "Note: GitHub Pages may take 1-2 minutes to deploy. If the site doesn't load immediately, wait and refresh."
