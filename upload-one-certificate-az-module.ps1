################## Inputs ##################
. .\config.ps1

################# Modules ###################
#install-module Az
Import-Module Az.Accounts -RequiredVersion 2.12.3
Import-Module Az.Resources -RequiredVersion 6.7.0

################## Azure login ###################
# Log in can be done different ways. https://learn.microsoft.com/en-us/powershell/azure/authenticate-azureps?view=azps-10.0.0
# Connect-AzAccount -tenantId $config_tenantId # Login with browser popup

############# Refer ##############
. .\00-certificate.ps1
# Using https://learn.microsoft.com/en-us/graph/applications-how-to-add-certificate?tabs=powershell
$ErrorActionPreference = 'Stop'
if (!$secureCertificatePassword)
{
    $secureCertificatePassword = Read-Host "Enter certificate password" -AsSecureString
}
$cer = Get-Certificate $config_pfxCertPath $secureCertificatePassword
$base64 = [System.Convert]::ToBase64String($cer.RawData)
New-AzADAppCredential -ObjectId $config_ObjectId -certvalue $base64 
"Certificate uploaded"

# upload same certificate to multiple app registrations
$config_objectIds | ForEach-Object { New-AzADAppCredential -ObjectId $_ -CertValue $base64 }