#!/bin/bash

# Loop through all markdown files in the current directory
for file in *.md; do
    # Use sed to find and replace the image links, removing "../" from the path
    sed -ri 's|!\[\]\(\/Images/|![](Images/|g' "$file"
done

