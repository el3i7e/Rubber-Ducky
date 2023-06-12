$sourceFolder = "C:\Users"
$destinationFolder = "D:\"
$monthAgo = (Get-Date).AddMonths(-1)

Get-ChildItem -Path $sourceFolder -Recurse -Filter *.docx | Where-Object { $_.LastWriteTime -ge $monthAgo } | Copy-Item -Destination $destinationFolder -Container -Force
