#!/bin/bash

# Check if URL file argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <url_file>"
    echo "Where <url_file> contains one URL per line"
    exit 1
fi

URL_FILE="$1"

# Check if the input file exists
if [ ! -f "$URL_FILE" ]; then
    echo "Error: File '$URL_FILE' not found"
    exit 1
fi

# Create downloads directory if it doesn't exist
mkdir -p downloads

# Initialize status files
PENDING_FILE="pending_downloads.txt"
COMPLETED_FILE="completed_downloads.txt"
FAILED_FILE="failed_downloads.txt"

# Copy input file to pending file initially
cp "$URL_FILE" "$PENDING_FILE"

# Clear completed and failed files
> "$COMPLETED_FILE"
> "$FAILED_FILE"

echo "Starting downloads from '$URL_FILE'"
echo "Downloads will be saved to './downloads/'"

# Process each URL
while IFS= read -r url; do
    # Skip empty lines
    if [ -z "$url" ]; then
        continue
    fi
    
    echo "Processing: $url"
    
    # Run yt-dlp with the URL
    yt-dlp -o "downloads/%(title)s.%(ext)s" "$url"
    exit_code=$?
    
    # Check exit code and categorize result
    case $exit_code in
        0)
            echo "✓ Success: $url"
            echo "$url" >> "$COMPLETED_FILE"
            ;;
        1)
            echo "✗ Failed (generic error): $url"
            echo "$url" >> "$FAILED_FILE"
            ;;
        2)
            echo "✗ Failed (user option error): $url"
            echo "$url" >> "$FAILED_FILE"
            ;;
        100)
            echo "! Update required: $url"
            echo "$url" >> "$FAILED_FILE"
            ;;
        101)
            echo "! Cancelled by user: $url"
            echo "$url" >> "$FAILED_FILE"
            ;;
        *)
            echo "✗ Failed (unknown error $exit_code): $url"
            echo "$url" >> "$FAILED_FILE"
            ;;
    esac
    
    # Remove processed URL from pending file
    grep -v "^$url$" "$PENDING_FILE" > temp_pending && mv temp_pending "$PENDING_FILE"
    
done < "$URL_FILE"

echo ""
echo "Download process completed!"
echo "Results:"
echo "- Completed: $(wc -l < "$COMPLETED_FILE" 2>/dev/null || echo 0) downloads"
echo "- Failed: $(wc -l < "$FAILED_FILE" 2>/dev/null || echo 0) downloads"
echo "- Pending: $(wc -l < "$PENDING_FILE" 2>/dev/null || echo 0) downloads"
echo ""
echo "Check these files for details:"
echo "- $COMPLETED_FILE (successful downloads)"
echo "- $FAILED_FILE (failed downloads)"
echo "- $PENDING_FILE (remaining URLs)"