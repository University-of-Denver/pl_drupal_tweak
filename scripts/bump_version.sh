#!/bin/bash

# To use this script, first make it executable by running 'chmod +x scripts/bump_version.sh'
# Then run the script with either "./scripts/bump_version.sh <VERSION NUMBER>" or "bash scripts/bump_version.sh <VERSION NUMBER>"

# Resolve the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Assume the repo root is the parent of the script directory
REPO_ROOT="$SCRIPT_DIR/.."

NEW_VERSION=$1

FILES=(
  "$REPO_ROOT/composer.json"
  "$REPO_ROOT/pl_drupal_tweak.info.yml"
  "$REPO_ROOT/pl_drupal_tweak.info.yml"
  "$REPO_ROOT/subthemes/pl_www_tweak/pl_www_tweak.info.yml"
  "$REPO_ROOT/subthemes/pl_unit_tweak/pl_unit_tweak.info.yml"
  "$REPO_ROOT/subthemes/pl_micro_tweak/pl_micro_tweak.info.yml"
)

for FILE in "${FILES[@]}"
do
  if [ ! -f "$FILE" ]; then
    echo "$FILE not found, skipping."
    continue
  fi

  if [[ "$FILE" == *.json ]]; then
    sed -i '' -E 's/("version":[[:space:]]*")[0-9]+\.[0-9]+\.[0-9]+(")/\1'"$NEW_VERSION"'\2/' "$FILE"
  elif [[ "$FILE" == *.yaml || "$FILE" == *.yml ]]; then
    sed -i '' -E 's/version: *[0-9]+\.[0-9]+\.[0-9]+/version: '"$NEW_VERSION"'/' "$FILE"
  fi

  echo "$FILE version bumped to $NEW_VERSION"
done