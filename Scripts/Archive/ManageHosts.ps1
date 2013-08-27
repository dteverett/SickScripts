

Function set-Prod()
{
    $current = get-location
    cd C:\windows\System32\drivers\etc
    copy C:\windows\system32\drivers\etc\hosts.Prod C:\windows\system32\drivers\etc\hosts
    ipconfig /flushdns
    cd $current
    "Hosts File Successfully Set to Production Environment Variables"
}

Function set-Dev()
{
    $current = get-location
    $pth = "C:\windows\system32\drivers\etc"
    cd $pth
    copy $pth\hosts.Dev $pth\hosts
    ipconfig /flushdns
    cd $current
    "Hosts File Successfully Set to Development Environment Variables"
}

