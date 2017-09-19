# CHANGELOG

The change-log below has been generated using the Git history in the repo.


### Latest

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
