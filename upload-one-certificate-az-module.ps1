################## Inputs ##################
. .\config.ps1

################# Modules ###################
#install-module Az
Import-Module Az.Accounts
Import-Module Az.Resources
#https://learn.microsoft.com/en-us/azure-stack/operator/azure-stack-powershell-install?view=azs-2301

################## Azure login ###################
# Log in can be done different ways. https://learn.microsoft.com/en-us/powershell/azure/authenticate-azureps?view=azps-10.0.0
# Connect-AzAccount -tenantId $config_tenantId # Login with browser popup

############# Refer ##############
. .\00-certificate.ps1
# Using https://learn.microsoft.com/en-us/graph/applications-how-to-add-certificate?tabs=powershell
if (!$secureCertificatePassword)
{
    $secureCertificatePassword = Read-Host "Enter certificate password" -AsSecureString
}
$cer = Get-Certificate $config_pfxCertPath $secureCertificatePassword
"Read certificate. Thumbprint: $($cer.thumbprint)"
$CertCredential = @{
    Type = "AsymmetricX509Cert"
    Usage = "Verify"
    Key = $cer.RawData
}
New-AzADAppCredential -ObjectId $config_ObjectId -KeyCredentials @($CertCredential)
"Certificate uploaded"