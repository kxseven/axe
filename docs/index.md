# AXE - The Cloud Hatchet

## What is AXE and how can it help me?

- The AXE tools are a collection of Python and BASH helper scripts that are intended to augment your existing interaction with AWS by
    + Helping with the loading of AWS credentials into the environment that can be re-used by all of your existing AWS toolset; Terraform, AWS CLI, Terraforming, Ansible, etc
    + Helping to generate useful information about existing resources you already have on AWS in a format that can be used as part of a pipeline for other tools/apps


## Components

The AXE toolset is seperated into distinct components;

![AXE Components](media/images/axe_components.png)

1. The AXE tools themselves (eg. axe list ec2-instance)
2. Identity and Credential management that manipulates the active identity to facilitate multiple sets of credentials across many separate stacks (eg. aws.conf)


## How it fits together

![AXE Workflow](media/images/axe_workflow.png)

 - AXE: load an identity from one of the configured IDs in `~/.axe` which manipulates the default `AWS_....` environment variables that many of the AWS tools support
     + `$AWS_CONFIG_FILE`
     + `$AWS_DEFAULT_REGION`
     + `$AWS_ACCESS_KEY_ID`
     + `$AWS_SECRET_ACCESS_KEY`

![AXE STS Token Valid](media/images/axe_cred_token_valid.png)

 - AXE: use some of the commands provided to interact with your virtual infrastructure
 - Use any other tools that support loading credentials from the shell envionment; [Terraform], [saws], [terraforming], etc
 - The CLI helper will also show the active AWS profile as well as the remaining time on the STS token if using MFA or Federated Access (Suggestions for better colors welcome)

![AXE STS Token Expired](media/images/axe_cred_token_expired.png)


[Terraform]: http://terraform.io/
[saws]: https://github.com/donnemartin/saws
[terraforming]: https://github.com/dtan4/terraforming

