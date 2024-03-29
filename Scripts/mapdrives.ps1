$currentLocal = (get-Location).Path

Net use A: /delete /y
Met use B: /delete /y
Net use D: /delete /y
Net use E: /delete /y
Net use F: /delete /y
Net use G: /delete /y
Net use H: /delete /y
Net use I: /delete /y
Net use J: /delete /y
Net use K: /delete /y
Net use L: /delete /y
Net use M: /delete /y
Net use N: /delete /y
Net use O: /delete /y
Net use P: /delete /y
Net use Q: /delete /y
Net use R: /delete /y
Net use S: /delete /y
Net use T: /delete /y
Net use U: /delete /y
Net use V: /delete /y
Net use W: /delete /y
Net use X: /delete /y
Net use Y: /delete /y
Net use Z: /delete /y

Net use F: \\TestFiler\ApexData
Net use R: \\ApexData\rawFiles
Net use Z: \\ApexData\data
Net use Y: \\ApexData\F_Drive_Test
Net use H: \\Hedgefrog\root
Net use P: \\Polarshark\root
Net use U: \\apexfiler\userdata\deverett

Set-Location C:\Windows\System32\
Push-Location

Set-Location HKCU:

Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##ApexData#F_Drive_Test\
Set-ItemProperty . _LabelFromDesktopINI "ApexData\F_Drive_Test\"

Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##testfiler#apexdata\
Set-ItemProperty . _LabelFromDesktopINI "TestFiler\ApexData"

Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##ApexData#rawFiles\
Set-ItemProperty . _LabelFromDesktopINI "ProductionRawFiles"

Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##apexData#data\
Set-ItemProperty . _LabelFromDesktopINI "ApexData\Data\"



Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##Hedgefrog#root\
Set-ItemProperty . _LabelFromDesktopINI "Hedgefrog\root\"

Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2\##Polarshark#root\
Set-ItemProperty . _LabelFromDesktopINI "Polarshark\root\"

Set-Location $currentLocal