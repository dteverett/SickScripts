. C:\Scripts\TemplateEngine.ps1

$pwd = "C:\scripts"

Invoke-Template "$pwd\ect" {
    ([xml] (Get-Content .\Properties.xml)).properties.property |
        Foreach {
            $type = $_.type
            $name = $_.name
            Get-template properties.txt
        }
}