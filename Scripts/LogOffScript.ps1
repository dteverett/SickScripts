

    set-location 'HKCU:\software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders'
    Set-ItemProperty . Personal "C:\users\deverett\archive\dummyDocuments"
    set-location 'HKCU:\software\microsoft\windows\currentversion\explorer\User Shell Folders'
    Set-ItemProperty . Personal "C:\users\deverett\dummyDocuments"



    C:\windows\system32\logoff.exe
