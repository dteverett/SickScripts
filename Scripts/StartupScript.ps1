    
#    C:\windows\system32\windowspowershell\v1.0\powershell.exe
    
    Start-Sleep -Seconds 30

    set-location 'HKCU:\software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders'
    Set-ItemProperty . Personal "C:\users\deverett\darianDocuments"
    set-location 'HKCU:\software\microsoft\windows\currentversion\explorer\User Shell Folders'
    Set-ItemProperty . Personal "C:\users\deverett\darianDocuments"


    Write-Host "Documents changed to C:\users\deverett\darianDocuments"


    C:\scripts\mapdrives.ps1