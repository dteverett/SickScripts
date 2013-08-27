function batch-filename([string] $name)
{
    if($name.Length -lt 13)
    {
        return
    }
    $sub = $name.Substring(0, 10)
    $id = $name.Substring(10)

    $name = $sub + "." + $id

}