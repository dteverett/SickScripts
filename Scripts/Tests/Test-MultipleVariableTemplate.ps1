. .\TemplateEngine.ps1

$pwd = "C:\scripts"

Invoke-Template "$pwd\ect" {
    
    $type = "string"
    $name = "FirstName"
    Get-Template properties.txt

    $type = "DateTime"
    $name = "Date"
    Get-Template privateSet.txt}