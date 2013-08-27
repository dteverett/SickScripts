
param([string]$folder, [string]$name)

$dirPath = "\\apexdata\data\Apex Policies and Procedures\QA\TestCases\$folder"
$masterPath = "\\apexdata\data\Apex Policies and Procedures\QA\TestCases\$folder\testcasetemplate.xlsx"
$filePath = "\\apexdata\data\apex policies and procedures\qa\testcases\$folder\$name.xlsx"
$dirExists = test-path $dirPath
if(!$dirExists)
{
    ni $dirPath -type d -Force
}
$testExists = Test-Path $masterPath
if(!$testExists)
{
    Copy-Item '\\apexdata\data\apex policies and procedures\qa\testcases\masters-donotedit\testcasetemplate.xlsx' -Destination $masterPath
}
Copy-Item $masterPath $filePath
$filePath
cd $dirPath
dir