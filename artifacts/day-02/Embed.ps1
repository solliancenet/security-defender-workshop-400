function CreateMacro($file)
{
    $raw = get-content $file -raw;
    $encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($raw));

    $cmd = "strCommand = `"powershell.exe -encodedCommand $encoded`"";

    return $cmd;
}

$path = "C:\github\solliancenet\security-defender-workshop-400\artifacts\day-02";

$file = "$path\Enumerate.ps1";

$cmd = CreateMacro $file;

$cmd;