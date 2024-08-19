#!/bin/bash

#generate a pre-signed URL for sharing access to an S3 object.
create_shareable_link() {
    echo $(aws s3 presign s3://"$BUCKET_NAME"/$(basename "$1") --expires-in 10800)
}

#function for uploading file or directory to cloud
Upload_File_To_Cloud() {

    local file_name="$1"

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
for file_path in "$@"; do
    if [[ ! -e "$file_path" ]]; then
        echo " "$file_path" is not a file/directory."
    else
        Upload_File_To_Cloud "$file_path"
    fi
done