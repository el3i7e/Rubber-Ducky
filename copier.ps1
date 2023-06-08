$destinationDirectory = "D:\"
$startDate = (Get-Date).AddMonths(-1)

# Get all .docx files modified within the last month from any directory
$files = Get-ChildItem -Recurse -Filter "*.docx" |
         Where-Object { $_.LastWriteTime -ge $startDate }

# Copy all .docx files to the destination directory
foreach ($file in $files) {
    $destinationPath = Join-Path -Path $destinationDirectory -ChildPath $file.FullName.Substring(3)
    Copy-Item -Path $file.FullName -Destination $destinationPath
}
