function OpenISA {
    param(
    [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline=$true)]
    [string[]] $path,
    [Parameter(Mandatory = $false)]
    [switch] $PassThru
    )
    BEGIN {
        if (!$psISE)
        {
        "Not in powershell ISE window"}        }
    Process {
        if ($psISE) {
            foreach ($file in $path) { 
                if (Test-Path $file) {
                    Get-ChildItem $file | foreach {
                        $file = $psISE.CurrentPowerShellTab.Files.Add($_.FullName)
                        if ($PassThru) {
                            $file
                            }}
                    }
                }
            }
    }
}