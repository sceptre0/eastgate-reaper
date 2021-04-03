Import-Module BitsTransfer

Write-Host "Reaper Setup Script"

$RecordingDate = Get-Date -Format yyyy-MM-dd
$RecordingDateIncTime = Get-Date -Format yyyy-MM-dd-HHmm
Set-Location "C:\recordings"
$RecordingDirectory=".\$RecordingDateIncTime";
$Destination = "\\VBOXSVR\scripts"
$Timeout = 10 # seconds
if(!(Test-Path -path $RecordingDirectory))
 {
     New-Item -Itemtype directory -Path $RecordingDirectory
     Write-Host "Folder path has been created successfully at: " $RecordingDirectory

 }
 else {
     Write-Host "The folder name $RecordingDirectory already exists"
 }

Write-Host "*** Preparing Template file ***"
Start-sleep -s 5
Copy-Item "C:\Recordings\Eastgate-Broadcast-Template.RPP" -Destination "$RecordingDirectory\$RecordingDateIncTime.RPP" 

# Launch Reaper - leave script running
Write-Host "Launching Reaper....." -ForegroundColor magenta
Write-Host ""
Start-sleep -s 5
Invoke-Item "./$RecordingDirectory/$RecordingDateIncTime.RPP"




Write-Host "Preparing to copy files to server" -ForegroundColor magenta
Write-Host ""
Write-Host "Note:The computer will automatically shutdown once the transfer is complete." -ForegroundColor red

# Prompt to Copy Files to server
$confirmation = Read-Host "Are you sure you want to proceed: Enter y or n " 
if ($confirmation -eq 'y') {
    Write-Host "Copy starting"
    Write-Host ""
    New-Item -Itemtype directory -Path "$Destination\$RecordingDirectory"
    Write-Host "Destination Directory created"
    # Copy LV1 Session file to destination
    Write-Host "Copy LV1 Session file to NAS started"
    # copy-item -path "\\lv1\c$\Users\Public\Waves\eMotion\$RecordingDate.emo" -Destination "$Destination"
    Write-Host "Copy LV1 Session file to NAS finished"
  # Copy Reaper Session files to destination
  Write-Host "Copy Reaper Session files to NAS started"
  
    Start-BitsTransfer -Source $RecordingDirectory\*.* -Destination "$Destination\$RecordingDirectory" -Description "Server-Transfer" -DisplayName "Server-Transfer"
    Write-Host "Copy Reaper Session files to NAS finished"
    Write-Host "Transfers Complete.....Shutting Down"
   # start-sleep -s 5
   # Stop-Computer -ComputerName localhost
}
else  {
    Write-Host "Copy cancelled"
}