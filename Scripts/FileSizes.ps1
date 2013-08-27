Function get-size([string] $path)
{
$path
$path.Length


if ($path.Length -gt 1)
{
$colItems = (get-childitem $path -Recurse | Measure-object -property length -sum)
"{0:N2}" -f ($colitems.Sum / 1MB) + " MB"
}
else
{
$colItems = (get-childitem -Recurse | Measure-Object -Property length -sum)
"{0:N2}" -f ($colItems.Sum / 1MB) + " MB"
}
}


Function get-size_fancy([string] $path)
{
    if($path.Length -gt 1)
    {
        $startFolder = $path
    }
    else
    {
        $startFolder = (get-location).Path
    }

    $colItems = (get-childItem $startFolder | Measure-Object -property length -sum)
    "$startFolder -- " + "{0:N2}" -f ($colItems.Sum / 1MB) + " MB"

    $colItems = (Get-Childitem $startFolder -Recurse | Where-Object { $_.PSIsContainer -eq $true } | Sort-Object )
    foreach($i in $colItems)
    {
        $subFolderItems = (Get-Childitem $i.FullName | Measure-Object -property length -sum)
        $i.FullName + " -- " + "{0:N2}" -f ($subFolderItems.Sum / 1MB) + " MB"
    }
}

Function get-size_cheating([string] $path)
{
    $objFSO = New-Object -com Scripting.FileSystemObject
    "{0:N2}" -f (($objFSO.GetFolder("$path").Size) / 1MB) + " MB"
}
