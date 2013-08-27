

function Pause ($Message="Press any key to continue...")
{
Write-Host -NoNewLine $Message
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
Write-Host ""
}


function copydowntest ()
{
ROBOCOPY \\TestFiler\ApexData\Programs\1touch\ C:\onetouch\ /v /tee /R:1 /W:1
ROBOCOPY \\TestFiler\ApexData\Programs\apexwatcher\ C:\apexwatcher\ /V /TEE /R:1 /W:1
ROBOCOPY \\TestFiler\Apexdata\Programs\AutoImport5010\ C:\AutoImport5010\ /V /TEE /R:1 /W:1
ROBOCOPY \\TestFiler\ApexData\Programs\ClaimStaker64\ C:\ClaimStaker\ /V /TEE /R:1 /W:1
ROBOCOPY \\TestFiler\ApexData\Programs\ClaimStakerPlus C:\ClaimStakerPlus\ /V /TEE /R:1 /W:1
ROBOCOPY \\TestFiler\ApexData\Programs\Output5010\ C:\output5010\ /V /TEE /R:1 /W:1
}