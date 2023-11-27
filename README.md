# Lambda Secrets in env variables

The script will **enumerate all lambdas on all regions**, and for each lambda will print the environment variables to look up for secrets or sensitive data.

The script `lambda.sh` wull run using the AWS CLI and **indicate the ones that have environment vars configured**.

**Improvements TODO**
- *Check for secrets on the code, downloading the code and parsing it to find sensitive data*

## Quick start
```bash
bash lambda.sh profile1 [profile2 profile3 ...]
```
