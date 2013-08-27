
Function Format-ECFFile([string] $file)
{
$reg1 = "\s\s+"
$replace1 = ", "
$reg2 = "\d+,\s\d+,\s\d+,\s\d+,\s"

$oldfile = "C:\users\deverett.APEX\desktop\uploads\temp\ECFIndex.txt"
$newfile = "C:\users\deverett.APEX\desktop\uploads\temp\CSVECFIndex.txt"

if($file.Length -lt 2)
{
    $text = (get-content -path $oldfile -raw)
}
else
{
    $text = (get-content -path $file -raw)
}

[System.Text.RegularExpressions.Regex]::Replace($text, $reg1, $replace1) | Set-Content -Path $newfile

$text = (Get-Content -path $newfile -raw)

$regex = New-Object System.Text.RegularExpressions.Regex $reg2

$matchEvaluator = [System.Text.RegularExpressions.MatchEvaluator]
{ 
    [String]::Format("$args`n ")   
}

$result = $regex.Replace($text, $matchEvaluator) | Set-Content -Path $newfile

Invoke-Item -path $newfile
}


Function Another-Regex([string] $file)
{
    
}

