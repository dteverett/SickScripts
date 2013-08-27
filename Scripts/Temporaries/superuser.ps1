


$oldLocation = "C:\users\deverett\desktop\tmp\testing\old"
$newLocation = "C:\users\deverett\desktop\tmp\testing\new"

cd $newLocation
dir | % {  $name = $_.Name + ".original";
            ren $_ $name;
        }
copy $oldLocation\* $newLocation
