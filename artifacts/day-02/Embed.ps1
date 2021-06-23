function CreateMacro($file)
{
    $encoded = EncodeScript $file;

    $cmd = "strCommand = `"powershell.exe -encodedCommand $encoded`"";

    return $cmd;
}

function EncodeScript($file)
{
    $raw = get-content $file -raw;
    $encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($raw));
    return $encoded;
}

$path = "C:\github\solliancenet\security-defender-workshop-400\artifacts\day-02";

$file = "$path\Enumerate.ps1";

$cmd = EncodeScript $file;

#$cmd = CreateMacro $file;

$cmd;