function Invoke-Template {
    param(
        [string] $path,
        [scriptblock]$ScriptBlock
    )

    function Get-Template {
        param($TemplateFileName)
        $content = [IO.File]::ReadAllText(
            (Join-Path $path $TemplateFileName) )
         Invoke-Expression "@`"`r`n$content`r`n`"@"
           
    }

    & $ScriptBlock
}

#example
#Invoke-Template "$pwd\ect" {
# $type = "string"
# $name = "FirstName"
# Get-Template properties.txt
# }