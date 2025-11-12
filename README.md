# Personal Portfolio Website (Automated with Terraform) 🚀

This is my personal portfolio website, built with **HTML, CSS, and JS**. The entire infrastructure—from S3 bucket creation to file uploads—is automatically deployed and managed using **Terraform**.

## Features
-   Responsive design 📱
-   Dark/light theme toggle 🌙
-   Built with clean HTML, CSS, and vanilla JS
-   **Automated Deployment:** Infrastructure is managed as code (IaC) with Terraform.

## Architecture
The infrastructure is defined in Terraform and consists of:
1.  **AWS S3:** An S3 bucket configured for static website hosting.
2.  **AWS CloudFront:** (Your next step) A CDN distribution for global delivery, HTTPS, and caching.
3.  **Terraform:** Manages all resources, including file uploads based on changes (`etag`).

(Managed by Terraform) → AWS S3 Bucket → User 🌍

## Project Structure
The repository is organized into two main parts:
-   `/website`: Contains all the application source code (HTML, CSS, JS, images).
-   `/terraform`: Contains all the Infrastructure as Code (IaC) files (`main.tf`) that define the AWS resources.

## How to Deploy
This project can be deployed to your own AWS account in minutes.

### Prerequisites
1.  An [AWS Account](https://aws.amazon.com/)
2.  [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) installed
3.  AWS credentials configured (e.g., via `aws configure`)

### Deployment Steps
1.  Clone this repository.
2.  Navigate to the Terraform directory:
    ```sh
    cd terraform
    ```
3.  Initialize Terraform (this downloads the AWS provider):
    ```sh
    terraform init
    ```
4.  Preview the changes:
    ```sh
    terraform plan
    ```
5.  Apply the configuration to build the infrastructure:
    ```sh
    terraform apply
    ```
Terraform will create the S3 bucket, set the policies, upload the files, and output the final website URL.

## Live Demo
**ayushranjan.me**
