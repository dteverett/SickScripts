
$folder = "$dropbox\Communication"
$filter = '*.*'

$fsw = New-Object IO.FileSystemWatcher $folder, $filter -Property @{IncludeSubdirectories =
 $true;NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite, LastAccess'}

 
 Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action {
    $name = $Event.SourceEventArgs.Name
    $changeType = $Event.SourceEventArgs.ChangeType
    $timeStamp = $event.TimeGenerated
    Write-Host "The file '$name' was $changeType at $timeStamp" -fore green
    Out-File -FilePath C:\scripts\filechange\outlog.txt -Append -InputObject
    "The file '$name' was $changeType at $timeStamp"}
   
 Register-ObjectEvent $fsw Deleted -SourceIdentifier FileDeleted -Action {
    $name = $Event.SourceEventArgs.Name 
$changeType = $Event.SourceEventArgs.ChangeType 
$timeStamp = $Event.TimeGenerated 
Write-Host "The file '$name' was $changeType at $timeStamp" -fore red 
Out-File -FilePath c:\scripts\filechange\outlog.txt -Append -InputObject "The file '$name' was $changeType at $timeStamp"} 


Register-ObjectEvent $fsw Changed -SourceIdentifier FileChanged -Action { 
$name = $Event.SourceEventArgs.Name 
$changeType = $Event.SourceEventArgs.ChangeType 
$timeStamp = $Event.TimeGenerated 


Write-Host "The file '$name' was $changeType at $timeStamp" -fore white 
Out-File -FilePath c:\scripts\filechange\outlog.txt -Append -InputObject "The file '$name' was $changeType at $timeStamp"} 

<# 
# To stop the monitoring, run the following commands: 
# Unregister-Event FileDeleted 
# Unregister-Event FileCreated 
# Unregister-Event FileChanged
#>