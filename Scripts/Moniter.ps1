  #moniter
$folder = "\\polarshark\root\uploads"
$filter = '*.*'
#$log = "C:\users\deverett.APEX\dariandocuments\MoniterLogs\log.txt"

$fsw = New-Object IO.FileSystemWatcher $folder, $filter -Property @{IncludeSubdirectories =
 $true;NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite, LastAccess'}
 
 Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action {
    $name = $Event.SourceEventArgs.Name
    $changeType = $Event.SourceEventArgs.ChangeType
    $timeStamp = $event.TimeGenerated
    $filename = "$folder\$name"

    Write-Host "The file '$name' was $changeType at $timeStamp" -fore green
    C:\scripts\MoveFiles.ps1
    Out-File -FilePath C:\scripts\filechange\outlog.txt -Append -InputObject
    "The file '$name' was $changeType at $timeStamp"
    #Out-File -FilePath $log -Append -InputObject
    #"The file '$name' was $changeType at $timeStamp"

    $pathExists = Test-Path $filename
    while($pathExists)
    {
        try
        {
            Write-Host "Attempting to delete '$name'" -fore Yellow
            Remove-Item $filename
            #Start-Sleep -Seconds 10
            
            $pathExists = Test-Path $filename
        }
        catch [System.Exception]
        {
            Write-Host "An exception occured trying to delete '$name'" -fore DarkRed

        }
    Write-Host "The file '$name' was deleted" -ForegroundColor Blue
    }

    }
 
 <#
 Register-ObjectEvent $fsw Deleted -SourceIdentifier FileDeleted -Action {
    $name = $Event.SourceEventArgs.Name 
$changeType = $Event.SourceEventArgs.ChangeType 
$timeStamp = $Event.TimeGenerated 
Write-Host "The file '$name' was $changeType at $timeStamp" -fore red 
Out-File -FilePath c:\scripts\filechange\outlog.txt -Append -InputObject "The file '$name' was $changeType at $timeStamp"} 
 #>

Register-ObjectEvent $fsw Changed -SourceIdentifier FileChanged -Action { 
$name = $Event.SourceEventArgs.Name 
$changeType = $Event.SourceEventArgs.ChangeType 
$timeStamp = $Event.TimeGenerated 
#C:\Scripts\deleteIntruder.ps1 $folder\$name
Write-Host "The file '$name' was $changeType at $timeStamp" -fore white 
C:\scripts\MoveFiles.ps1
Out-File -FilePath c:\scripts\filechange\outlog.txt -Append -InputObject "The file '$name' was $changeType at $timeStamp"
#Out-File -FilePath $log -Append -InputObject "The file '$name' was $changeType at $timeStamp"
} 
 
# To stop the monitoring, run the following commands: 
# Unregister-Event FileDeleted 
# Unregister-Event FileCreated 
# Unregister-Event FileChanged



