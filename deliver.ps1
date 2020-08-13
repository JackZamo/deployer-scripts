Write-Host "deliver the deployment bundles"

$Headers = @{
    Authorization = $basicAuthValue
}


if (Test-Path C:\node\deploy\bulk.zip)
{
    Write-Host "Backing up bulk.zip"
    Rename-Item -Path "c:\node\deploy\bulk.zip" -NewName c:\node\deploy\bulk.zip.$(get-date -f MM-dd-yyyy_HH_mm_ss)
}
else
{
Write-Host "No bulk.zip so skipping step"
}

if (Test-Path C:\node\deploy\bulk)
{
    Write-Host "Backing up bulk folder"
    Rename-Item -Path "c:\node\deploy\bulk" -NewName c:\node\deploy\bulk.$(get-date -f MM-dd-yyyy_HH_mm_ss)
}
else
{
Write-Host "No bulk folder so skipping step"
}


Write-Host "Copying Archive from pub folder to deploy folder"

Copy-Item "c:/node/pub/bulk.zip" "c:/node/deploy/bulk.zip"

Write-Host "Expanding Archive"

expand-archive -path c:/node/deploy/bulk.zip -destination c:/node/deploy/bulk

Write-Host "Done"

Write-Host "delivered the deployment archives successfully."

Remove-Item c:\node\deploy\results1.log

Start-Process -wait -ver runAs powershell "C:\node\deploy\deployer.ps1 *> c:\node\deploy\results1.log" 

gc c:\node\deploy\results1.log

