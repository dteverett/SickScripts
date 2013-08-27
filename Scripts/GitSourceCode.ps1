
Function Git-SourceCode()
{    
    $folder = dir -Path \\testweb\c\TeamCity\buildAgent\work | where { $_.Name -ne ".old" -and $_.PSIsContainer } | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    $name = $folder.Name

    $fullPath = "\\testweb\c\TeamCity\buildAgent\work\$name"
    $destination = "\\testfiler\apexdata\qafiles\Rpstry"

    ROBOCOPY $fullPath $destination /e /MT:12 /XO /R:12 /W:5 

}