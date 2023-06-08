$startDate = (Get-Date).AddMonths(-1)
Get-ChildItem -Recurse -Filter *.pdf | Where-Object { $_.CreationTime -ge $startDate -or $_.LastWriteTime -ge $startDate } | Copy-Item -Destination "D:\"
