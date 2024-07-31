# Terraform Deployment Pipeline

This GitHub Actions workflow automates the deployment of Terraform configurations. It supports deployment to different environments (`dev` and `prod`), ensuring that deployments to the production environment can only occur from the `main` branch.

## Workflow Overview

The workflow is triggered by the following events:
- `push` to any branch
- `pull_request` to any branch
- Manually via `workflow_dispatch` with specified inputs

### Workflow Inputs

- **environment**: The target environment for the deployment (`dev` or `prod`).
- **action**: The action to perform (`apply`).
- **apply_approval**: Optional approval for the apply action (boolean).

### Jobs

The workflow consists of two main jobs: `build` and `apply`.

#### Build Job

This job performs the following steps:
1. **Checkout code**: Checks out the code from the repository.
2. **Set up Terraform**: Sets up Terraform with the specified version.
3. **Terraform Init**: Initializes Terraform with the backend configuration.
4. **Terraform Format**: Formats the Terraform configuration files.
5. **Terraform Validate**: Validates the Terraform configuration.
6. **Terraform Plan**: Creates a Terraform execution plan.
7. **Upload Plan**: Uploads the generated plan as an artifact.

#### Apply Job

This job performs the following steps:
1. **Check if main branch for prod**: Ensures deployment to `prod` is only from the `main` branch. Skips the job if the condition is not met.
2. **Checkout code**: Checks out the code from the repository.
3. **Download Plan**: Downloads the previously generated Terraform plan.
4. **Set up Terraform**: Sets up Terraform with the specified version.
5. **Terraform Init**: Reinitializes Terraform with the appropriate configuration.
6. **Terraform Apply**: Applies the Terraform plan to the specified environment.

## Setting Up in GitHub

To set up this workflow in your GitHub repository, follow these steps:

1. **Create the Workflow File**:
   - Create a directory named `.github/workflows` in the root of your repository.
   - Inside this directory, create a file named `terraform-deployment.yml`.
   - Copy the provided workflow YAML into this file.

2. **Set Up Secrets**:
   - Go to your repository settings on GitHub.
   - Navigate to the `Secrets` section.
   - Add the following secrets:
     - `AWS_ACCOUNT`: Your AWS account ID.
     - `AWS_ACCESS_KEY_ID`: Your AWS access key ID.
     - `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key.
     - `TF_STATE_BUCKET`: The S3 bucket for Terraform state.
     - `TF_VAR_REGION`: The AWS region for your deployment.

3. **Run the Workflow**:
   - The workflow will automatically run on `push` and `pull_request` events.
   - You can manually trigger the workflow using the `workflow_dispatch` event from the GitHub Actions tab in your repository.

### Example `workflow_dispatch` Inputs

To manually trigger the workflow, provide the following inputs:

- **environment**: Choose between `dev` and `prod`.
- **action**: Set to `apply`.
- **apply_approval**: Optionally set to `true` for approval.

## Notes

- The `apply` job includes a condition to ensure that deployments to the `prod` environment can only occur from the `main` branch.
- If attempting to deploy to `prod` from a branch other than `main`, the `apply` job will be skipped, and a message will be logged.

This setup ensures a controlled and automated deployment process for your Terraform configurations, with additional safeguards for production deployments.
