$sourceDirectory = "C:\"  # Replace with the root directory you want to search
$destinationDirectory = "D:\"

# Calculate the date from one month ago
$startDate = (Get-Date).AddMonths(-1)

# Get all .docx files modified within the last month from any directory
$files = Get-ChildItem -Path $sourceDirectory -Filter "*.docx" -Recurse |
         Where-Object { $_.LastWriteTime -ge $startDate }

# Copy each .docx file to the destination directory
foreach ($file in $files) {
    $destinationPath = Join-Path -Path $destinationDirectory -ChildPath $file.FullName.Substring($sourceDirectory.Length)
    Copy-Item -Path $file.FullName -Destination $destinationPath
}
