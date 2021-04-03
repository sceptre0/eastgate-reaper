Write-Host "Reaper Setup Script"

$RecordingDirectory="C:\Recordings\20210317";
if (!(Test-Path -path $RecordingDirectory))
 {
     New-Item -ItemType directory -Path $RecordingDirectory
     Write-Host "Folder path has been created successfully at: " $RecordingDirectory

 }
 else {
     Write-Host "The folder name $RecordingDirectory already exists"
 }
 