

function Get-DiskInfo
{
    [CmdletBinding(DefaultParameterSetName='integrated')]
    param
    (
        [Parameter(Mandatory=$false, ParameterSetName='integrated')]
        [Parameter(Mandatory=$true, ParameterSetName='credential')]
        $ComputerName,

        [Parameter(ParameterSetName='credential')]
        $Credential
    )

    if ($PSBoundParameters.ContainsKey('Credential') -and $Credential -is [String])
    {
        $PSBoundParameters.Credential = Get-Credential -UserName $Credential -Message 'Enter Password'
    }

    Get-WmiObject -Class Win32_LogicalDisk -Filter 'DriveType=3' @PSBoundParameters -ea Stop
}
