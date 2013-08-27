
Function renameassorterror([string] $path)
{
if($path -eq "")
{
    Get-ChildItem *.* | ForEach-Object {
        $newName = "_sorterror_" + $_
        Rename-Item -Path $_.FullName -NewName $newName
        }
}
else
{
    Get-ChildItem $path *.* | ForEach-Object {
        $newName = "_sorterror_" + $_
        Rename-Item -Path $_.FullName -NewName $newName
        }
}
}




#########################################################
#
# Function RENAME AS SORT ERROR
#
<#
Function renameassorterror([string] $path)
{
if($path -eq "")
    {
    Get-ChildItem | where { ! $_.PSIsContainer } | ForEach-Object {
        $newName = "_sorterror_" + $_.Name
        Rename-Item -Path $_.FullName -NewName $newName
        }
    }
else
    {
    Get-ChildItem $path *.* | ForEach-Object {
        $newName = "_sorterror_" + $_.Name
        Rename-Item -Path $_.FullName -NewName $newName
        }
    }
}

#>

