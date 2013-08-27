﻿#CLS
Import-CSV "C:\Scripts\Servers.csv" | % {
    $Server = $_.ServerName
 $adminpath = Test-Path "\\$Server\admin$"
 If ($adminpath -eq "True")
  {
         $hostfile = "\\$Server\c$\Windows\System32\drivers\etc\hosts"
         Write-Host –NoNewLine "Updating $Server..."
         "10.10.10.100`tMyhost" | Out-File $hostfile -encoding ASCII -append
         Write-Host "Done!"
        
    
  }
 Else
  {
            Write-Host -Fore Red "Can't Access $Server"
  }
 }