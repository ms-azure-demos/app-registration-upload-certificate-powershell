function Get-Certificate($certPath, [securestring]$secureCertificatePassword ){
    $cer = Get-PfxCertificate -FilePath $certPath -Password $secureCertificatePassword
    return $cer
}

