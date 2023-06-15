################## Inputs ###################
. .\config.ps1

################# Modules ###################
#Install-Module Microsoft.Graph.Applications -RequiredVersion 1.26.0
#Install-Module Microsoft.Graph.Authentication -RequiredVersion 1.26.0
Import-Module Microsoft.Graph.Authentication -RequiredVersion 1.26.0
Import-Module Microsoft.Graph.Applications

############# Login ##############
# Connect-MGGraph -TenantId $config_tenantId -Scopes Application.Read.All, Application.ReadWrite.All # Via user credentials by opening up browser
# Other ways to authenticate to Graph https://learn.microsoft.com/en-us/powershell/microsoftgraph/authentication-commands?view=graph-powershell-1.0

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
Update-MgApplication -ApplicationId $config_objectId -KeyCredentials @($CertCredential)
"Certificate uploaded"