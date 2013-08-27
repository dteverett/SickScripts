###################################### COPY CONFIGS #############################################
#
# Author: Darian Everett
# Date Created: 08/01/2013
# Date Last Modified: 08/01/2013
#
# The Purpose of this script is to copy all production and development configuration files to an
# archive as a backup.  The script also verifies that the production/development config files have 
# the correct connection strings and directory structures for the environment
#
# To run this script on your local machine, open a Powershell console and run the following command:
# set-executionPolicy RemoteSigned
#



$prod = "\\testfiler\apexdata\qafiles\configarchive\production"
$dev = "\\testfiler\apexdata\qafiles\configarchive\development"
$prodPath = "\\apexdata\data"
$devPath = "\\testfiler\programs"

$hashDev = $null
$hashProd = $null
$hashDev = @{}
$hashProd = @{}

$conn = "Connection String Error"
$dirs = "Base Directory Error"


$exten = ".exe.config"
$app = ".app.config"

$currentLocation = Get-Location

$d = (get-date).ToString()
$da = $d.Substring(0,9)
$dat = $da -replace '/', '_'

$newProd = "$prod\$dat"
$newDev = "$dev\$dat"

$newProd -replace " ",""
$newDev -replace " ",""

$boolProd = Test-Path $newProd
$boolDev = Test-Path $newDev

if(!$boolProd)
{
    ni -Path $newProd -type d
}
if(!$boolDev)
{
    ni -Path $newDev -type d
}

$Programs = @("ApexWatcher", "AutoImport5010", "Output5010") #Regular programs
$appPrograms = @("Claimstaker", "Claimstaker64") #Programs with an app.config
$OthersPlus = @("ClaimstakerUI", "RunClaimstakerUI") 
$otherClassic = "RunClaimstaker"

$string = "ApexWatcher"

foreach ( $item in $Programs) 
{ #Copy Production config files and verify they have the correct connection strings and base directories to belong in production  
    if(!$string.Equals($item))
    {
        Copy-Item -Path "$prodPath\$item\$item$exten" -Destination $newProd -force
        cd $prod
        $pth = dir | where { $_.PSIsContainer } | sort-object lastwritetime | Select-Object -First 1
        cd $pth
        $text = Get-Content -Path ".\$item$exten"
        if($text -match "APEXSQL") {$bool1 = $true } else { $bool1 = $false}
        if($text -match "\\\\Apexdata\\data") {$bool2 = $true } else {$bool2 = $false}
        if($bool1 = $false) { $hashProd.Add($item, $conn)}
        if($bool2 = $false) { $hashProd.Add($item, $dirs)}
    }
    else
    {
        Copy-Item -Path "$prodPath\Apps\$item\$item$exten" -Destination $newProd -Force
        cd $prod
        $pth = dir | where { $_.PSIsContainer } | sort-object lastwritetime | select-object -First 1
        cd $pth
        $text = get-content -Path ".\$item$exten"
        if($text -match "APEXSQL") {$bool1 = $true} else { $bool1 = $false }
        if($text -match "\\\\Apexdata\\data") {$bool2 = $true } else {$bool2 = $false}
        if($bool1 = $false) { $hashProd.Add($item, $conn)}
        if($bool2 = $false) { $hashProd.Add($item, $dirs)}
    }
    # Copy dev config files and verify
    Copy-Item -Path "$devPath\$item\$item$exten" -Destination $newDev -force
    cd $dev
    $pth = dir | where { $_.PSIscontainer } | Sort-object lastwritetime | Select-Object -first 1
    cd $pth
    $text = Get-Content -Path ".\$item$exten"
    if($text -match "testdb" -or $text -match "apexedi-dev\\apexedidev") { $bool1 = $true } else {$bool1 = $false}
    if($text -match "\\\\testfiler" -or $text -match "F_Drive_Test") { $bool2 = $true} else {$bool2 = $false}
    if($bool1 = $false) { $hashDev.Add($item, $conn ) }
    if($bool2 = $false) { $hashDev.Add($item, $dirs ) }

}

foreach ( $item in $appPrograms)
{
    Copy-item -path "$prodPath\$item\app.config" -Destination "$newProd\$item$app" -force
    cd $prod
    $pth = dir | where { $_.PSIsContainer } | Sort-Object lastwritetime | Select-Object -first 1
    cd $pth
    $text = Get-Content -Path ".\$item$app"
    if($text -match "apexsql"){$bool1 = $true} else {$bool1 = $false}
    if($text -match "\\\\apexdata\\data"){$bool2 = $true} else {$bool2 = $false}
    if($bool1 = $false){$hashProd.Add($item, $conn)}
    if($bool2 = $false){$hashProd.Add("$item.", $dirs)}

    Copy-item -Path "$devPath\$item\app.config" -Destination "$newDev\$item$app" -force
    cd $dev
    $pth = dir | where { $_.PSIsContainer } | Sort-Object lastwritetime | Select-Object -first 1
    cd $pth
    $text = Get-Content ".\$item$app"
    if($text -match "testdb" -or $text -match "apexedi-dev\\apexedidev"){$bool1 = $true}else{$bool1 = $false}
    if($text -match "\\\\testfiler" -or $text -match "F_Drive_Test"){$bool2 = $true}else{$bool2 = $false}
    if($bool1 = $false){$hashDev.Add($item, $conn)}
    if($bool2 = $false){$hashDev.Add("$item.", $dirs)}
}

foreach ( $item in $OthersPlus )
{
    Copy-Item -Path "$prodPath\ClaimstakerPlus\$item$exten" -Destination $newProd -force
    cd $prod
    $pth = dir | where { $_.PSIsContainer } | Sort-Object lastwritetime | Select-Object -First 1
    cd $pth
    $text = Get-Content -Path ".\$item$exten"
    if($text -match "APEXSQL") {$bool1 = $true } else { $bool1 = $false}
    if($text -match "\\\\Apexdata\\data") {$bool2 = $true } else {$bool2 = $false}
    if($bool1 = $false) { $hashProd.Add($item, $conn)}
    if($bool2 = $false) { $hashProd.Add("$item.", $dirs)}

    Copy-Item -Path "$devPath\ClaimstakerPlus\$item$exten" -Destination $newDev -force
    cd $dev
    $pth = dir | where { $_.PSIsContainer } | Sort-Object lastwritetime | Select-Object -First 1
    cd $pth
    $text = Get-Content -Path ".\$item$exten"
    if($text -match "testdb" -or $text -match "apexedi-dev\\apexedidev") { $bool1 = $true } else {$bool1 = $false}
    if($text -match "\\\\testfiler" -or $text -match "F_Drive_Test") { $bool2 = $true} else {$bool2 = $false}
    if($bool1 = $false) { $hashDev.Add($item, $conn ) }
    if($bool2 = $false) { $hashDev.Add("$item.", $dirs ) }
}

Copy-Item -Path "$prodPath\Claimstaker\$otherClassic$exten" -Destination $newProd -force
    cd $prod
    $pth = dir | where { $_.PSIsContainer } | Sort-Object lastwritetime | select-object -first 1
    cd $pth
    $text = Get-Content -Path ".\$otherClassic$exten"
    if($text -match "\\\\Apexdata\\data") {$bool2 = $true } else {$bool2 = $false}
    if($bool2 = $false) { $hashProd.Add($item, $dirs)}

Copy-item -Path "$devPath\Claimstaker\$otherClassic$exten" -Destination $newDev -force
    cd $dev
    $pth = dir | where { $_.PSIsContainer } | Sort-Object lastwritetime | Select-Object -First 1
    cd $pth
    $text = Get-Content -Path ".\$otherClassic$exten"
    if($text -match "\\\\testfiler" -or $text -match "F_drive_Test") {$bool2 = $true } else {$bool2 = $false}
    if($bool2 = $false) { $hashDev.Add($item, $dirs)}

cd $currentLocation

Write-Host
Write-Host
Write-Host "******************************************************"
Write-Host
Write-Host "Production Config Errors:"
Write-Host
$hashProd
Write-Host
write-host
write-host
Write-Host "Development Config Errors:"
Write-Host
$hashDev
Write-Host
write-host









