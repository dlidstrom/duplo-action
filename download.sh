#!/bin/bash

# Ensure the correct number of arguments
if [[ $# -ne 3 ]]; then
    echo "Usage: $0 <duplo_filename> <archive_output> <version>"
    exit 1
fi

# Assign arguments to variables
DUPLO="$1"
ARCHIVE="$2"
VERSION="$3"

# Fetch the releases JSON
echo "Fetching releases from GitHub..."
RELEASES_JSON=$(curl -s https://api.github.com/repos/dlidstrom/Duplo/releases)
echo "Fetched JSON data."

# Extract the correct release based on VERSION
echo "Filtering release for version: $VERSION"
RELEASE_JSON=$(echo "$RELEASES_JSON" | jq --arg tag "$VERSION" -r '.[] | select(.tag_name==$tag)')
echo "Filtered Release JSON:"
echo "$RELEASE_JSON"

# Extract assets array
echo "Extracting assets..."
ASSETS_JSON=$(echo "$RELEASE_JSON" | jq -r '.assets')
echo "Assets JSON:"
echo "$ASSETS_JSON"

# Find the correct asset by name
echo "Searching for asset named: $DUPLO"
DOWNLOAD_URL=$(echo "$ASSETS_JSON" | jq --arg name "$DUPLO" -r '.[] | select(.name==$name) | .browser_download_url')

# Log the extracted download URL
if [[ -n "$DOWNLOAD_URL" ]]; then
    echo "Found download URL: $DOWNLOAD_URL"
else
    echo "Error: No matching asset found for $DUPLO"
    exit 1
fi

# Download the file
echo "Downloading $DUPLO to $ARCHIVE..."
curl -L -o "$ARCHIVE" "$DOWNLOAD_URL"
echo "Download complete!"
