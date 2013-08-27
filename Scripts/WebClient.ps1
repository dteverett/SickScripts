$pth = "F:\qafiles\tmp\ApexWatcherTesting082013"

$clientzzz = new-object PSObject 
Add-Member -InputObject $clientzzz -MemberType NoteProperty -Name Username -Value "demo1"
Add-Member -InputObject $clientzzz -MemberType NoteProperty -Name Password -Value "medical1"
Add-Member -InputObject $clientzzz -MemberType NoteProperty -Name ClientID -Value "zzz"

$clientZZD = New-Object PSObject
Add-Member -InputObject $clientZZD -MemberType NoteProperty -Name Username -Value "demo2"
Add-Member -InputObject $clientZZD -MemberType NoteProperty -Name Password -Value "dental2"
Add-Member -InputObject $clientZZD -MemberType NoteProperty -Name ClientID -Value "ZZD"

$clients = @($clientzzz, $clientZZD)

$webClient = New-Object System.Net.WebClient

#$files = (gci -Path \\testfiler\apexdata\qafiles\tmp\ApexWatcherTesting082013).ToString()
$files = New-Object System.Collections.ArrayList

$array = gci -Path \\testfiler\apexdata\qafiles\claims -recurse | where { ! $_.PSIsContainer }

$array | % {
    $files.Add($_.FullName)
}
$files.Count
. C:\scripts\UploadMedical.ps1


for ($i=0;$i -le $clients.Length; $i++){
    $files | % {
        
        UploadMedical $clients[$i].Username $clients[$i].Password $_  -force
    }
}


