#!/bin/bash

# Script to fix malformed Freezed generated files
# This fixes the issue where doc comments appear on the same line as getters
# and ensures proper indentation

find lib -name "*.freezed.dart" -type f | while read file; do
    echo "Fixing $file..."

    # Step 1: Insert newline after getter semicolons before doc comments
    perl -i -pe 's/;\/\/\//;\n\n  \/\/\//g' "$file"

    # Step 2: Fix indentation of getters that only have 1 space
    perl -i -pe 's/^\s(String|int|bool|DateTime|List|Map|double|num) get /  $1 get /g' "$file"
done

echo "All freezed files fixed!"
