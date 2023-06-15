################## Inputs ##################
. .\config.ps1

################## Azure login ###################
# Log in can be done different ways. https://learn.microsoft.com/en-us/powershell/azure/authenticate-azureps?view=azps-10.0.0 
# az login --tenant $config_tenantId

############# Refer ##############
. .\00-certificate.ps1
# Using https://learn.microsoft.com/en-us/graph/applications-how-to-add-certificate?tabs=powershell
if (!$secureCertificatePassword)
{
    $secureCertificatePassword = Read-Host "Enter certificate password" -AsSecureString
}
$cer = Get-Certificate $config_pfxCertPath $secureCertificatePassword
# inprogress
#https://learn.microsoft.com/en-us/cli/azure/ad/app/credential?view=azure-cli-latest#az-ad-app-credential-list


