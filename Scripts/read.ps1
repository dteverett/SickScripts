Function Read ([string] $file)
{
$currentPath = (get-location).Path
$UNCPath = $pwd.ProviderPath
cd "C:\program Files (x86)\Notepad++\"
$firstMatch = $file -match "\.\\"
$doesMatch = $file -match "\\"
if($firstMatch -eq $true)
{
    $subfile = $file.Substring(2)
    $file = $subfile
    $completeFile = "$UNCPath\$file"
    .\notepad++.exe $completeFile
}
elseif($doesMatch -eq $true)
    {
    .\notepad++.exe $file
    }
else
    {
    $pathfile = $UNCPath + "\" + $file
    .\notepad++.exe $pathfile
    }
cd \
cd $currentPath
}