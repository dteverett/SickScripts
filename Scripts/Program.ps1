



Function Program ([string]$file)
{
$currentLocation = Get-Location
$UNCPath = $pwd.ProviderPath

cd C:\windows\system32\WindowsPowerShell\V1.0\

$doesMatch1 = $file -match "\.\\" #asking if the parameter contains .\

$doesMatch = $file -match "\\" #asking if parameter contains \  Above must be checked first and then if false check this to see if full path is included

if($file.Length -lt 2)
{
	.\powershell_ise.exe
}
elseif ($doesMatch1)
{
    $subFile = $file.Substring(2)
    $file = $subFile
    $fullPath = "$UNCPath\$file"
    .\powershell_ise.exe $fullPath
}
elseif ($doesMatch)
{
    .\powershell_ise.exe $file
}
else
{
    $pathFile = $UNCPath + "\" + $file
    .\powershell_ise.exe $pathFile
}
cd \
cd $currentLocation
}