function CreateFiles($count)
{
    mkdir $oneDrivePath -ea SilentlyContinue;

    #This will generate several random text files.
    $i = 0;

    while($i -le $count)
    {
        #add content
        $filePath = "$oneDrivePath\$i.txt";

        while($j -le $count)
        {
            add-content "$filePath" "$j";

            $j++;
        }

        $j = 0;
        $i++;
    }
}

function EncryptFiles($count)
{
    $cert = Get-Childitem -Path Cert:\CurrentUser\My -DocumentEncryptionCert;

    if (!$cert)
    {
        New-SelfSignedCertificate -DnsName defendme -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsage KeyEncipherment,DataEncipherment, KeyAgreement -Type DocumentEncryptionCert
    }    

    $di = new-object System.IO.DirectoryInfo($oneDrivePath);

    $files = $di.getfiles("*.*");

    foreach($file in $files)
    {
        $c = get-content $file.fullname;

        $c | Protect-CmsMessage -To cn=defendme -OutFile $file.fullname;
    }

    
}

$userPath = $env:USERPROFILE;
$oneDrivePath = "$userPath\OneDrive";