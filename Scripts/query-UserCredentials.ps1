
Function query-UserCredentials([string] $client)
{
    $SQLServer = "Testdb"
    $SqlDBName = "Claimstaker"
    $SqlQuery = "Select * from TestUserCredentials_T where clientID_VC = '$client'"

    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName;Persist Security Info=True;User ID=qauser;Password=eclaims1!;"

    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $SqlCmd.CommandText = $SqlQuery
    $SqlCmd.Connection = $SqlConnection

    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
    $SqlAdapter.SelectCommand = $SqlCmd

    $DataSet = New-Object System.Data.DataSet
    $SqlAdapter.Fill($DataSet)
    
    $SqlConnection.Close()

    $DataSet.Tables[0]

}


Set-Alias user "C:\scripts\query-UserCredentials.ps1"

