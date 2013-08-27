Function set-shortcut([string]$SourceExe, [string]$DestinationPath)
{
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($DestinationPath)
    $Shortcut.TargetPath = $SourceExe
    $Shortcut.Save()
}