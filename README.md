# AWS S3 CloudUploader CLI Tool☁️
A bash-powered command-line interface tool made to streamline file uploads to a cloud storage platform. It offers users a straightforward and effortless uploading process similar to leading storage services.

> [Learn to Cloud](https://learntocloud.guide/phase1/#capstone-project-clouduploader-cli) ☁️

## Prerequisites ✋

1. Requires an AWS account with an IAM user with permissions to full access of Amazon S3.
2. AWS CLI installed.
3. Configure your AWS CLI with valid IAM user credentials. [docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
4. This is a Bash script so will only work for Linux/Mac OS. If you are using Windows consider using Windows Subsystem for Linux(WSL). [WSL Installation Guide](https://learn.microsoft.com/en-us/windows/wsl/install)

## Setup and Installation 

1. Using the command line interface. Create an environment variable to store your S3 Bucket name. Replace `<your-bucket-name>` with the name of your S3 Bucket.

```
export BUCKET_NAME=<your-bucket-name>
```

2. After cloning the repository, navigate to the repository directory.

3. Run **install.sh** with the command:

```
./install.sh
```

- **If you get a permission denied error, run: `sudo chmod +x install.sh`**.
- **If you still cannot run the script, try: `sudo ./scriptinstaller.sh`**.

4. A successful installation should return the message: **"Installation sucessful. You can now call clouduploader.sh from anywhere."**

- **If the script is already installed at bin directory, you will get the message: "The script is already installed."**

5. Verify that you can call the cloud uploader script by using the command: `./clouduploader.sh` or `sh clouduploader`. It should return the message: "No file path provided.", since you did not provided any file or path as an argument.

## How to use

### Single file:

```
clouduploader.sh file1.txt
```

### Multiple files:

```
clouduploader.sh ~/Documents/Projects/songapi.py ./file1.txt ~/CloudDir
```

### Directories

```
clouduploader.sh ~/CloudDir
```



- **If uploading the file(s) to the S3 bucket is successful, the CLI will ask if you want to create a shareable link to see what is inside the file uploaded to the bucket. Proceed with 'Y' or 'y' to generate the link**.
- **Shareable links do not work for Directories**
- **You can upload a file with any extension, with however many files/arguments you want but each CLI argument cannot exceed 160 GB**.