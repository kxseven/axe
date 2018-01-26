# CHANGELOG

The change-log below has been generated using the Git history in the repo.

### v1.6

 - Added basic JQF filter for instances vs SSM status
 - Updated list sub-command to support additional enrichment stage in the processing pipeline. Updated filters affected
 - Added SSL Cert id to ELB filter
 - Updated list sub-command for handling of more complex aws-cli commands
 - Added windows remote connectivity support in Requirements for Ansible
 - Updated list sub-command to better handle command labels in JQF files
 - Added basic filter for SSM
 - Updated PS1 handling to default to unpatched fonts
 - Fixes for duplicates in EC2 instance list
 - Updates and improvements to resolve AXE-2
 - Updated inventory reporting to meet criteria for AXE-3. Filtered resources now use the "#geo: global" indicator to identify that they are global resources

### v1.5

!!! warning "Update Python Packages"
    This release requires updates to one or more Python libraries used. Please ensure you run a `pip install -r <requirements>` after updating from a previous release

 - Updated Release notes for v1.5
 - Added and updated new sub-commands for inventory reporting and diagram generation
 - Updated EBS snapshot filter to list only snapshots we created
 - Added internal argument for listing completions
 - Minor correction on function name
 - Added new subcommand for VPC visualization and Graphviz DOT output
 - Added list filter for RouteTable
 - Updated min version of Jinja2 for new vpc-viz subcommand
 - Added completion rule for development sub-command
 - Added support for VPCs with multiple CIDR blocks
 - Updated docs for more info on using generators
 - Added jqf filter to demo new list sub-command support for generators
 - Updated list-command to support complex generator commands
 - Fixes for filters
 - Fixes for list filters

### v1.4

 - Updated RNs for release
 - Added improved version of json2table for use with list sub-command. Legacy command will be removed once all other sub-commands have been migrated
 - Updated filters for list sub-command
 - Added more filters for list sub-command
 - Added filters for IGW and ALB to list sub-command
 - Updated axemap tool to reflect changes in sub-commands
 - Updated requirements for Py2.7 and Py3x
 - Added requirements file for adding Ansible to help support dynamic inventory

### v1.3

 - Updated Release Notes
 - Added documentation for new sub-command
 - Added helper sub-command to calculate S3 bucket sizes
 - Added more filters to list sub-command
 - Added basic filter for Route53 zones
 - Added more AWS filters for "list" sub-command

### v1.2

 - Added sub-command to assist with creating simple identities
 - Updated Release Notes
 - Legacy sub-command cleanup and updates to docs to match
 - Removed legacy commands whose functionalist is now provided by new "list" sub-command
 - Adeed BASH completion for new axe-list sub-command
 - Added generic "list" sub-command to support more extensible filtering of resources
 - Updated RN

### v1.1

 - Updated documentation for PS1 hook
 - Updated docs for new PS1 hook
 - Updated PS1 hook to only trigger from initial shell loading
 - Added PS1 hook for a powerline type experience when using a supported (Bash) shell
 - Cleanup
 - Updated changelog after tagging for version

### v1.0

 - Updated README with correct rtd URLs
 - Minor fix for correct helper-script path
 - Requirements cleanup
 - Rewrite of the documentation to make it easier to use. Nobody should need to be a blackbelt in HFSBL4 in order to use AXE
 - Removed legacy creation commands. Other tools (terraform) manage creation of resources much better
 - Updated credentials loading helper
 - Updated _ts() to remove dependency on xargs
 - Updated dump-account sub command to dump all available regions
 - Added simple whoami utility
 - Ensure spaces in section names got replaced with underscores
 - Added support for claiming multiple IPs from a single subnet
 - Added fix to ensure that AWS commands generate JSON output
 - Added support for asking for the Kerberos Realm Principal at run-time to support multi-user workspace
 - Improved cleanup() for axe-docs
 - Moved cleanup function to ensure it was available for times it could be triggered
 - Corrected version issue in requirements
 - Corrected typo in requirements
 - Updated requirements to specify min versions instead of fixed versions
 - Add dry-run mode by default to SG utility
 - Corrected var name in SG utility
 - Updated SG addition tool to apply more filters
 - Added SG addition utility
 - Updated axegrep to auto-cleanup the input more
 - Minor changes for consistency
 - Small improvements to json2table utility
 - mkdocs theme cleanup
 - Updated requirements and docs
 - Added IAM Server Certificate reporting utility
 - Corected dependency package names
 - Updated fix for URL handling in forms
 - Added Troubleshooting section to docs
 - Fixed issue with form action URL in Kerberos based auth
 - Updated docs and requirements
 - Cleanup of legacy sub-commands

### v0.9

 - First commit after rebase of code, following cleanup prior to public release. Contributors have been noted in CONTRIBUTORS.md for reference.
