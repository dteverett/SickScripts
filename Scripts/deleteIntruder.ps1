
param([string] $filename)

$log = "C:\users\deverett.APEX\dariandocuments\MoniterLogs\log.txt"

    $pathExists = Test-Path $filename
    while($pathExists)
    {
        try
        {
            Remove-Item $filename
            Start-Sleep -Seconds 10
            $pathExists = Test-Path $filename
        }
        catch [System.Exception]
        {
            $message = $_ 

        }
    }
