#!/bin/bash

#Author: Angel C.
#Date: 08/20/2024
#Language: Bash
#Description: CLI tool used to upload local files/directories to your AWS s3 bucket.

#generate a pre-signed URL for sharing access to an S3 object.
create_shareable_link() {
    echo $(aws s3 presign s3://"$BUCKET_NAME"/$(basename "$1") --expires-in 10800)
}

#menu function for listing available s3 buckets
Available_S3_Buckets_Menu() {

    local file_path="$1"

    echo "Debug: Received file path: '$file_path'"

    ## Prompts bucket selection
    echo -e "Available S3 Buckets:\n"
    aws s3 ls
    read -r -p "Select a bucket: " BUCKET_NAME

    ## Bucket and file verifications
    if aws s3api head-bucket --bucket "$BUCKET_NAME" 1>/dev/null 2>/dev/null; then
        echo -e "\n✓ :Bucket permissions"
    else
        echo "❌ Error – bucket doesn't exist."
        exit 2
    fi

    echo "Debug: Verifying file path: $file_path"
    ls -l "$file_path"

    if [ -f "$file_path" ]; then
        echo -e "✓ File (upload) permissions"
    else
        echo "❌ Error - file doesn't exist"
        exit 2
    fi
}

#function for uploading file or directory to cloud
Upload_File_To_Cloud() {

    local file_name="$1"

    echo "Debug: Uploading file/directory '$file_name' to bucket '$BUCKET_NAME'"

    #checks to see if path to file is a directory or file
    if [[ -d "$file_name" ]]; then
        response=$(aws s3 cp "$file_name" s3://"$BUCKET_NAME"/$(basename "$file_name") --recursive)
    else
        response=$(aws s3 cp "$file_name" s3://"$BUCKET_NAME")
    fi
    
    #prints error message if upload fails/success message if so 
    if [[ $? -ne 0 ]]; then
        echo "Error unable to upload file(s)."
        echo "Error: $response"
    else
        echo "Files Successfully Uploaded!"
        #if file path is not a directory then it will ask user if they want a shareable link
        if [[ ! -d "$file_name" ]]; then
            echo -n "Create Shareable Link?(Y/n): "
            read users_response
            #if user chooses 'y' or 'Y' it calls 
            if [[ "$users_response" == 'y' || "$users_response" == 'Y' ]]; then
                create_shareable_link "$file_name"
            fi
        fi
    fi
}

#main script/ iterates through all arguments from user and checks to see if file or directory exist
if [[ $# -eq 0 ]]; then
    echo "No file path provided."
    exit 1
fi

for file_path in "$@"; do
    if [[ ! -e "$file_path" ]]; then
        echo " "$file_path" is not a file/directory."
    else
        Available_S3_Buckets_Menu "$file_path"
        Upload_File_To_Cloud "$file_path"
    fi
done