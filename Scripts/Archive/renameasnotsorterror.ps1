Function renameasnotsorterror([string] $path)
{
if($path -eq "")
    {
        Get-ChildItem -Filter *.* | Foreach-object {
                $oldname = $_.Name
                $newName = $oldname -replace '_sorterror_', ''
                Rename-Item -Path $_.FullName -NewName $newName
            }
    }
else
    {
        Get-ChildItem $path -Filter *.* | ForEach-Object {
        $oldname = $_.Name
        $newName = $oldname -replace '_sorterror_', ''
        Rename-Item -Path $_.FullName -NewName $newName
        }
    }
}

<#

########################################################
#
# Function RENAME AS NOT SORT ERROR

Function renameasnotsorterror([string] $path)
{
if($path -eq "")
    {
        Get-ChildItem | where { ! $_.PSIsContainer } | Foreach-object {
                $oldname = $_.Name
                $newName = $oldname -replace '_sorterror_', ''
                Rename-Item -Path $_.FullName -NewName $newName
            }
    }
else
    {
        Get-ChildItem $path -Filter *.* | ForEach-Object {
        $oldname = $_.Name
        $newName = $oldname -replace '_sorterror_', ''
        Rename-Item -Path $_.FullName -NewName $newName
        }
    }
}

#>




