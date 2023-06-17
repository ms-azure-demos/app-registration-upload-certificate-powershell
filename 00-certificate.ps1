function Get-Certificate($certPath, [securestring]$secureCertificatePassword ){
    $cer = Get-PfxCertificate -FilePath $certPath -Password $secureCertificatePassword
    "Read certificate. Thumbprint: $($cer.thumbprint)"
    return $cer
}