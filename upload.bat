@echo off

setlocal enabledelayedexpansion

set file_extensions=.txt .docx .pdf .png .jpg .mp3 .mp4
set file_list=
set zip_file=D:\compiled_files.zip

for /r %%F in (%file_extensions%) do (
    if exist "%%F" (
        set "file_path=%%~dpF"
        if exist "!file_path!" (
            set "file_list=!file_list! "!file_path!""
        )
    )
)

echo Creating zip file...
powershell -Command "$fileList = %file_list%; Compress-Archive -Path $fileList -DestinationPath \"%zip_file%\""
if %ERRORLEVEL% neq 0 (
    echo Failed to create zip file.
    exit /b 1
)

echo File Successfully Compressed and Saved to: %zip_file%

exit /b 0
