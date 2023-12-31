# Upload X509 certificate to Azure App registration(s) using PowerShell
PowerShell script to upload certificate to Azure application registrations

# How to run
Can be run 2 ways.

## As a user

- Update the values in config.ps1
- Login using the method mentioned in the respective .ps1 files
- Make sure there is enough permission on the account
- Make sure selecting right AAD tenant id if there are multiple tenants.
- Two approaches are available
    - Run [Az Commandlets](./upload-one-certificate-az-module.ps1) that uses Azure Az PowerShell commandlets
    - Run [Graph SDK for PowerShell](./upload-one-certificate-graphapi.ps1) that uses Graph API 

## As automation account
- Login using stored credentials
- Different methods to login are available in the link mentioned in respective .ps1 files
- Make sure there is enough permission on the account
- Make sure selecting right AAD tenant id if there are multiple tenants.
- Two approaches are available
    - Run [Az Commandlets](./upload-one-certificate-az-module.ps1) that uses Azure Az PowerShell commandlets
    - Run [Graph SDK for PowerShell](./upload-one-certificate-graphapi.ps1) that uses Graph API