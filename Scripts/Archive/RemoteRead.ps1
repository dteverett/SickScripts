#################################
# Function REMOTE READ
# Opens a file from the network in Notepad++

Function RemoteRead([string] $file)
{
    $currentLocation = (get-location).Path
    $copyPath = 'C:\users\deverett.APEX\Desktop\tmp\RemoteReading'
    $doesMatch = $file -match "\\"
    $doesMatch2 = $file -match "\.\\"
    if($doesMatch2)
    {
        $newFile = $file.Substring(2)
        copy $currentLocation\$newFile $copyPath
    }
    elseif($doesMatch)
    {
        copy $file $copyPath
    }
    else
    {
        copy $currentLocation\$file $copyPath
        $newFile = $file
    }
    $file = "$copyPath\$newFile"
    cd 'C:\Program Files (x86)\Notepad++'
    .\notepad++.exe $file
    cd \
    cd $currentLocation
}