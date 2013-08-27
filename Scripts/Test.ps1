"Hello Justin" -match "justin"    #true, default is insensitive
"Hello Justin" -cmatch "justin"  #false, case does not match
"Hello Justin" -imatch "justin"   #true, explicit case insensitivity

$is = "Hello Justin"

$is -match "justin"