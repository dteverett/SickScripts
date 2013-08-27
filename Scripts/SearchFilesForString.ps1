$regex = "Apex\.ImportingServices\.Contracts\.IDocumentImportService"

dir F:\QAFiles\Rpstry *.CS -Recurse | select-string $regex | ForEach { $fileName = $_.Path; ForEach($match in $_.Matches) { 
    New-Object PSObject -Property @{ FileName = $fileName ; Name = $match.Groups["name"].Value 
    Value = $match.Groups["value"].Value}}} > C:\scripts\results.txt
