# CHANGELOG

The change-log below has been generated using the Git history in the repo.

### v1.0

#### Hugh Mooney (34):
 - Cleanup of legacy sub-commands
 - Updated docs and requirements
 - Fixed issue with form action URL in Kerberos based auth
 - Added Troubleshooting section to docs
 - Updated fix for URL handling in forms
 - Corected dependency package names
 - Added IAM Server Certificate reporting utility
 - Updated requirements and docs
 - mkdocs theme cleanup
 - Small improvements to json2table utility
 - Minor changes for consistency
 - Updated axegrep to auto-cleanup the input more
 - Added SG addition utility
 - Updated SG addition tool to apply more filters
 - Corrected var name in SG utility
 - Add dry-run mode by default to SG utility
 - Updated requirements to specify min versions instead of fixed versions
 - Corrected typo in requirements
 - Corrected version issue in requirements
 - Moved cleanup function to ensure it was available for times it could be triggered
 - Improved cleanup() for axe-docs
 - Added support for asking for the Kerberos Realm Principal at run-time to support multi-user workspace
 - Added fix to ensure that AWS commands generate JSON output
 - Added support for claiming multiple IPs from a single subnet
 - Ensure spaces in section names got replaced with underscores
 - Added simple whoami utility
 - Updated dump-account sub command to dump all available regions
 - Updated _ts() to remove dependency on xargs
 - Updated credentials loading helper
 - Removed legacy creation commands. Other tools (terraform) manage creation of resources much better
 - Rewrite of the documentation to make it easier to use. Nobody should need to be a blackbelt in HFSBL4 in order to use AXE
 - Requirements cleanup
 - Minor fix for correct helper-script path
 - Updated README with correct rtd URLs


### v0.9

#### Hugh Mooney (1):
 - First commit after rebase of code, following cleanup prior to public release. Contributors have been noted in CONTRIBUTORS.md for reference.
