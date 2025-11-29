#!/bin/bash

# Script to fix malformed Freezed generated files
# This fixes the issue where doc comments appear on the same line as getters

find lib -name "*.freezed.dart" -type f | while read file; do
    echo "Fixing $file..."
    # Use perl to insert newlines after getters but before doc comments
    perl -i -pe 's/;\/\/\//;\n\n\/\/\//g' "$file"
done

echo "All freezed files fixed!"
