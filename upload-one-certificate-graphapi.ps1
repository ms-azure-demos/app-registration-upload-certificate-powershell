################## Inputs ###################
. .\config.ps1

################# Modules ###################
Import-Module Microsoft.Graph.Authentication -RequiredVersion 1.26.0
Import-Module Microsoft.Graph.Applications -RequiredVersion 1.26.0

################### Login ###################
# Connect-MGGraph -TenantId $config_tenantId -Scopes Application.Read.All, Application.ReadWrite.All # Via user credentials by opening up browser
# Other ways to authenticate to Graph https://learn.microsoft.com/en-us/powershell/microsoftgraph/authentication-commands?view=graph-powershell-1.0

################### Refer ###################
. .\00-certificate.ps1
# Using https://learn.microsoft.com/en-us/graph/applications-how-to-add-certificate?tabs=powershell
$ErrorActionPreference = 'Stop'
if (!$secureCertificatePassword)
{
    $secureCertificatePassword = Read-Host "Enter certificate password" -AsSecureString
}
$cer = Get-Certificate $config_pfxCertPath $secureCertificatePassword
$CertCredentials = @(
    @{
        Type = "AsymmetricX509Cert"
        Usage = "Verify"
        Key = [byte[]]$cer.RawData
    }
)

Update-MgApplication -ApplicationId $config_objectId -KeyCredentials $CertCredentials
"Certificate uploaded"

# Incase multiple app registrations needs to get same certificate.
#$config_objectIds | foreach { Update-MgApplication -ApplicationId $_ -KeyCredentials $CertCredentials }

# long typed way to create the key credentials
# $keycredentials = New-Object -TypeName "Microsoft.Azure.PowerShell.Cmdlets.Resources.MSGraph.Models.ApiV10.MicrosoftGraphKeyCredential" `
#                                  -Property @{
#                                     'Key' = $cer.RawData ;
#                                     'Usage'       = 'Verify';
#                                     'Type'        = 'AsymmetricX509Cert'
#                                 }