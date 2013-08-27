
Function query ([string]$query)
{
$SQLServer = "Testdb"
$SqlDBName = "Claimstaker"
$SqlQuery = "select * from claimmedicalbase_T where clientid_VC = 'cui'"

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName;Persist Security Info=True;User ID=qauser; Password=eclaims1!;"

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = $SqlQuery
$SqlCmd.Connection = $SqlConnection

$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd

$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)

$SqlConnection.Close()

clear

$DataSet.Tables[0]


}

Function query-other([string] $query)
{
     "Select database:"
     "1. Apexedi-dev"
     "2. ApexSQL"
     "3. Other"
     $response = Read-Host "User Selection: "

     if($response -eq 3)
     {
        $SQLServer = "APEXAPPS\TIMEFORCE"
        $SqlDBName = "Qqest"
     }

     $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
     $SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName;Persist Security Info=True;User ID=administrator; Password=firefoxvs.IE9;"

     $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
     $SqlCmd.CommandText = $query
     $SqlCmd.Connection = $SqlConnection

     $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
     $SqlAdapter.SelectCommand = $SqlCmd

     $DataSet = New-object System.Data.DataSet
     $SqlAdapter.Fill($DataSet)

     $SqlConnection.Close()

     $DataSet.Tables[0]


}

