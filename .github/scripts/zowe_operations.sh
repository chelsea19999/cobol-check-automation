
#!/bin/bash

# Zowe operations script
# COBOL Check Automation

set -e

# Convert username to lowercase
LOWERCASE_USERNAME=$(echo "$ZOWE_USERNAME" | tr '[:upper:]' '[:lower:]')

# Define USS directory
USS_DIRECTORY="/z/$LOWERCASE_USERNAME/cobolcheck"

# Check if directory exists; create it if necessary
if ! zowe zos-files list uss-files "$USS_DIRECTORY" &>/dev/null; then
    echo "Directory does not exist. Creating it..."

    zowe zos-files create uss-directory "$USS_DIRECTORY"
else
    echo "Directory already exists."
fi

# Upload COBOL Check files
echo "Uploading COBOL Check files..."

zowe zos-files upload dir-to-uss "./cobol-check" "$USS_DIRECTORY" \
    --recursive \
    --binary-files "cobol-check-0.2.9.jar"

# Verify upload
echo "Verifying upload:"

zowe zos-files list uss-files "$USS_DIRECTORY"

echo "Zowe operations completed successfully."
