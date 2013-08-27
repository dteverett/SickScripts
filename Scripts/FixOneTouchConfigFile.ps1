
Function Fix-OneTouch()
{
    $config = "\\polarshark\onetouch.apexedi.com\web.config"

    $text = (get-content -path $config -raw)

    $regex = "\<staticContent\>\s*\<.*?/?.*?/\>\s*\</staticContent\>"
    $replace = ""

    [System.Text.RegularExpressions.Regex]::Replace($text, $regex, $replace) | Set-Content -Path $config


}