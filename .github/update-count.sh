#!/usr/bin/env bash
# Writes all-time contributions into README. contributionsCollection spans one year at most.
set -euo pipefail
total=0
for y in $(seq 2023 "$(date -u +%Y)"); do
  n=$(gh api graphql --jq '.data.user.contributionsCollection.contributionCalendar.totalContributions' \
    -f query="query{user(login:\"JiCorrales\"){contributionsCollection(from:\"$y-01-01T00:00:00Z\",to:\"$y-12-31T23:59:59Z\"){contributionCalendar{totalContributions}}}}")
  total=$((total + n))
done
sed -i -E "s|(<!-- contributions -->).*(<!-- /contributions -->)|\1$total\2|" README.md
