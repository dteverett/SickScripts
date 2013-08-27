$content = [Ordered] @{
    User = $env:USERNAME
    OS = (Get-WmiObject Win32_OperatingSystem).Caption
    BIOS = (Get-WmiObject Win32_BIOS).Version
    ID = 12
}