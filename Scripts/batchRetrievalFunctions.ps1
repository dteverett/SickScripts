<#
	.Description
	The batchRetrievalFunctions.ps1 script contains the following functions:
	Add-DecimalToBatches [string]$file
	Find-Batches [string]$source, [string] $destination
	Get-Batches [string]$content
	Get-Refd9Batches
	Get-nonRefd9Batches
	
	.Detailed
	Add-DecimalToBatches -> param([string]$file) Requires a text file that contains batch numbers as stored in the database.
	The function will go through and add decimals to the batches to format them according to their names on the file system.
	Designed to be used in conjunction with Find-Batches
	
	Find-Batches -> param([string]$source, [string]$destination) $Source is a text file that is the output of Add-DecimalToBatches.
	This batch will look in the R: drive for all batches listed in the $source, and if found, copy said file to the $destination
	
	Get-Batches -> param([string]$content) Designed to be a combination of Add-DecimalToBatches and Find-Batches, $content may be 
	either pipelined or (for more reliable functionality) a text file.  The destination is hard-coded into this function
	
	Get-RefD9Batches -> param([string]$destination) This function copies 15 files into the $destination unless called without $destination,
    in which case the files are copied to the default, hard-coded location. This function will also not copy a file if it already exists in
    the new location.  This is designed to be a function that can
	be run multiple times consecutively, depending on the number of batches required, without ever copying the same
	file twice.  Furthermore, this function will only copy batches that contain a Ref*d9 segment
	
	Get-NonRefD9Batches -> param([string]$destination) The same function as Get-RefD9Batches, except that instead of only copying batches that
	contain RefD9Segment(s), this function only copies batches that don't have a RefD9Segment
	
	.Examples


#>





Function Add-DecimalToBatches([string] $file)
{
    $text = (Get-Content -Path $file -raw)
    $regex = "\d{10}"
    $replace = New-Object System.Text.RegularExpressions.Regex $regex
    $matchEvaluator = [System.Text.RegularExpressions.MatchEvaluator]{
        [String]::Format("$args.");
    }
    $replace.Replace($text, $matchEvaluator) | Set-Content -Path $file 
}


Function Find-Batches([string] $source, [string] $destination)
{ 
    if ($source.Length -lt 2)
    {
        $source = "C:\users\deverett\desktop\tmp\batches.txt"
    }
    $content = (get-content -path $source) 
    
    for($i = 0; $i -lt $content.Length; $i++ ) 
    { 
        if([Regex]::IsMatch($content[$i], "S?\d{10}\.\w{3}"))
        {
            $path = "R:\" + $content[$i]
            $path
            Copy-Item -Path $path -Destination $destination
        }
    }
}


Function Get-batches
{
	param([string]$content)
	$regex = "\d{10}"
	$replace = New-Object System.Text.RegularExpressions.Regex $regex
    $matchEvaluator = [System.Text.RegularExpressions.MatchEvaluator]{
        [String]::Format("$args.");
    }
    $replace.Replace($content, $matchEvaluator)
    
    for($i = 0; $i -lt $content.Length; $i++ ) 
    { 
        if([Regex]::IsMatch($content[$i], "S?\d{10}\.\w{3}"))
        {
            $path = "R:\" + $content[$i]
            $path
            Copy-Item -Path $path -Destination 'C:\users\deverett\DarianDocuments\Visual Studio 2012\Projects\VendorProjectTesting\VendorProjectTesting\bin\Debug\Files\Medical'
        }
    }
}


Function get-REFD9Batches
{
	param([string]$destination)
    $currentLocation = Get-Location
	if($destination.Length -lt 2)
    {
        $copyLocation = "\\testfiler\apexdata\qafiles\claims\refD9Batches\"
    }
    else
    {
        $copyLocation = $destination
    }

    cd R:
    $count = 0
    $maxCount = 15
    $regex = "REF\*D9\*\w+?~"
    $regex2 = "\d{10}\.\w{3}"
    $q = "select top 1000 batchNumber_VC from ClaimMedicalbase_T cmb
          inner join Provider_T p on cmb.Provider_ID = p.Provider_ID
          where p.SoftwareConversion_ID = 3446
          and ReportDate_DT > DATEADD(Year, -1, getdate())
          group by batchnumber_VC
          order by BatchNumber_VC desc"

    $content = query $q
    $content > C:\tmp\tempBatchList.txt
    Add-DecimalToBatches C:\tmp\tempBatchList.txt
    
    $content = get-content C:\tmp\tempBatchList.txt

    for($i = 0; $count -le $maxCount; $i++)
    {
        if([Regex]::IsMatch($content[$i], $regex2))
        {
            $b = $content[$i]
            $currentBatchPath = "R:\$b"
            $alreadyHave = "$copyLocation$b"
            $bool1 = Test-Path $currentBatchPath
            $bool2 = Test-Path $alreadyHave
            if($bool1 -and ! $bool2)
            {
                $batchContent = get-content $currentBatchPath
                $hasRefD9 = [Regex]::IsMatch($batchContent, $regex)
                if($hasRefD9)
                {
                    copy $content[$i] $copyLocation -Force
                    $count++;
                    Write-Host $b
                }
            }
        }
    }
    set-location $currentLocation
}



Function get-NonREFD9Batches
{
    param([string]$destination)
    $currentLocation = Get-Location
	if($destination.Length -lt 2)
    {
        $copyLocation = "\\testfiler\apexdata\qafiles\claims\refD9Batches\"
    }
    else
    {
        $copyLocation = $destination
    }

    cd R:
    $count = 0
    $maxCount = 15
    $regex = "REF\*D9\*\w+?~"
    $regex2 = "\d{10}\.\w{3}"
    $q = "select top 1000 batchNumber_VC from ClaimMedicalbase_T cmb
          inner join Provider_T p on cmb.Provider_ID = p.Provider_ID
          where p.SoftwareConversion_ID = 3446
          and ReportDate_DT > DATEADD(Year, -1, getdate())
          group by batchnumber_VC
          order by BatchNumber_VC desc"

    $content = query $q
    $content > C:\tmp\tempBatchList.txt
    Add-DecimalToBatches C:\tmp\tempBatchList.txt
    
    $content = get-content C:\tmp\tempBatchList.txt

    for($i = 0; $count -le $maxCount; $i++)
    {
        if([Regex]::IsMatch($content[$i], $regex2))
        {
            $b = $content[$i]
            $currentBatchPath = "R:\$b"
            $alreadyHave = "$copyLocation$b"
            $bool1 = Test-Path $currentBatchPath
            $bool2 = Test-Path $alreadyHave
            if($bool1 -and ! $bool2)
            {
                $batchContent = get-content $currentBatchPath
                $hasRefD9 = [Regex]::IsMatch($batchContent, $regex)
                if(!$hasRefD9)
                {
                    copy $content[$i] $copyLocation -Force
                    $count++;
                    Write-Host $b
                }
            }
        }
    }
    set-location $currentLocation
}





































































