
############################# Temporary File For Statement Testing ##################################
# Created: 7/3/13
#
# Author:  Darian Everett
#
# Date Last Modified: 7/3/13
#
#

#### Functions ####

Function dirR()
{
    dir -path \\apexdata\R_Drive_Test | where { $_.LastWriteTime -gt (get-date).AddDays(-1) -and ! $_.PSIsContainer } | Sort-Object LastWriteTime
}

Function dirClient([string] $client)
{
    $path = "\\testfiler\apexdata\claimstaker\claims\backup\$client"
    dir -path $path | where { $_.LastWriteTime -gt (Get-Date).AddDays(-1) -and ! $_.PSIsContainer } | Sort-Object LastWriteTime
    
}


Function StartCrap
{
    param([int] $crap)

    if($crap -eq 1)
    {
        $current = Get-Location
        \\apexdata\data\Jake\TheBigRedButton\TheBigRedButton.exe
    }
    elseif(!$crap)
    {
        Write-Host "Function StartCrap requires 1 parameter of type [int]"
    }


}

Function CopyReport
{
	copy \\testfiler\apexdata\qafiles\reports\APXs_83520130708091206.dat \\testfiler\apexdata\claimstaker\reports\payerreports
}



#### Variables ####

$dumpDir = "\\TestFiler\ApexData\Source"
$exceptionDir = "\\TestFiler\ApexData\Exception"
$statements = "C:\users\deverett.APEX\desktop\uploads\statements"



