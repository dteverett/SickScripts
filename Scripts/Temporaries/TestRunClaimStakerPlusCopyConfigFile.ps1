

Function Test()
{
    $location = Get-Location
    cd C:\ClaimStakerPlus

    $pth = "\\testfiler\programs\claimstakerplus\claimstakerUI.exe.config"
    $new = "\\testfiler\programs\claimstakerPlus\ClaimstakerUI.exe.config.wiener"
    $hme = "C:\ClaimStakerPlus\ClaimstakerUI.exe.config"

    Get-ItemProperty -Path $hme
        
    get-content -Path $pth |
        ForEach-Object { $_ -replace "<", "»" } | Set-Content -Path $new -Force

    move $new $pth -Force

    Get-Content -Path $pth |
        ForEach-Object { $_ -replace "»", "<" } | Set-Content -Path $new -Force

    move $new $pth -Force

    .\runClaimStakerUI.exe
        
    Get-ItemProperty -Path $pth
        
    Get-ItemProperty -Path $hme

    Stop-Process -Name ClaimstakerUI

}