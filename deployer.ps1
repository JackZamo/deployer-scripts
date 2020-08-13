#Requires -RunAsAdministrator

# A deployment script for the info service and web tools.
# Take the zip archive in the deploy folder, unzip it
# stops the services
# backsup the current deployment
# deploys the new files
# restarts the services
# author - JackZ
# Ver - 0.4

Write-Host "deploying bulk Tool"

Write-Host "Check pre-requisities"

if (Test-Path C:\node\deploy\bulk)
{
    Write-Host "bulk Tool Deployment package located successfully"
}
else
{
Write-Host "Error:  bulk Tool Deployment package missing"
exit-psssession
exit
}


Write-Host "1/4 - Stopping and Disabling Bulk Notes Uploader tasks"

# need to run as admin for this to work


Stop-ScheduledTask -taskname BulkNoteUploader
Disable-ScheduledTask -taskname BulkNoteUploader
Get-ScheduledTask -taskname BulkNoteUploader

Write-Host "2/4 - Backing up current deployment"

Rename-Item -Path "c:\node\live\bulk" -NewName c:\node\live\bulk.$(get-date -f MM-dd-yyyy_HH_mm_ss)

Write-Host "3/4 - Deploying new package"

Move-Item -Path c:\node\deploy\bulk -Destination C:\node\live\bulk


Write-Host "4/4 - Restarting Service"

# need to run as admin for this to work


Enable-ScheduledTask -taskname BulkNoteUploader
Start-ScheduledTask -taskname BulkNoteUploader
Get-ScheduledTask -taskname BulkNoteUploader


#exit-psssession

Write-Host "Deployment Complete"