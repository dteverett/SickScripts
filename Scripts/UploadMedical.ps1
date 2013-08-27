
Function UploadMedical
{
    Param(
        [string]$username,
        [string]$password,
        [string]$file,
        [switch]$force
)
    if($force)
    {
        [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
    }
    $url = "https://polarshark/secure/OneTouchAPI.asmx/Upload"
    $webclient = new-object System.Net.WebClient
    $webclient.QueryString.Add("username", $username)
    $webClient.QueryString.Add("password", $password)
    $webClient.QueryString.Add("isClaim", $true)
    $webClient.QueryString.Add("DocumentType", "MedicalClaim")

    $response = $webClient.UploadFile($url, $file)
    $status = [System.Text.Encoding]::UTF8.GetString($response)
    $isSuccessful = [Regex]::IsMatch($status.ToString(), "Upload Successful")

    Write-Host $status.ToString()
}
