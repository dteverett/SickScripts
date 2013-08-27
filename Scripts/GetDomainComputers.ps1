Function Get-DomainComputers()
{

$strCategory = "computer"

$objDomain = New-Object System.DirectoryServices.DirectoryEntry  #Defaults to root of domain w/out further arguments

$objSearcher = New-Object System.DirectoryServices.DirectorySearcher #object to search the domain
$objSearcher.SearchRoot = $objDomain                        #Telling the searcher to start in $objDomain, which is root of domain
$objSearcher.Filter = ("(objectCategory=$strCategory)")  #filtering results, in this case, only returning "computer" objects 

$colProplist = "name", "cn", "ipv4Address" #array of what we want returned

foreach ($i in $colProplist){ $objSearcher.PropertiesToLoad.Add($i)} #Add items to search for to the DirectorySearcher

$colResults = $objSearcher.FindAll()

foreach ($objResult in $colResults)
    { $objComputer = $objResult.Properties; $objComputer.name }

}