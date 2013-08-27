#Fixpermissions

$rootfolder = Get-ChildItem -Path \\apexfiler\userdata
foreach ($userfolder in $rootfolder) {
        $userfolder.FullName
        If (get-qaduser "apex\$userfolder") {
            Get-Acl $userfolder.FullName | Format-List
            $acl = Get-Acl $userfolder.FullName
            $acl.SetAccessRuleProtection($True, $False)
            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
            $acl.RemoveAccessRuleAll($rule)
            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrators","FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
            $acl.AddAccessRule($rule)
            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule($userfolder.Name,"Modify", "ContainerInherit, ObjectInherit", "None", "Allow")
            $acl.AddAccessRule($rule)
            $acct=New-Object System.Security.Principal.NTAccount("apex",$userfolder.name)
            $acl.SetOwner($acct)
            Set-Acl $userfolder.FullName $acl
            Get-Acl $userfolder.FullName  | Format-List
        }
}