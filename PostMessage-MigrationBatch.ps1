Clear-Host
Set-Location -Path $PSScriptRoot

# Input Parameters  
$developerToken = Read-Host 'Enter Your Yammer Developer Token' -MaskInput
$groupId= Read-Host 'Input the Encoded Yammer Group'
$BatchFileName= Read-Host 'Input the Name of XLS Batch file'

if (Get-Module -ListAvailable -Name 'ImportExcel')
{
    Write-Host "Module exists. Nothing to do!" -ForegroundColor Magenta
} 
else
{
    Write-Warning "ImportExcel module not present. Installation in progress"
    Install-Module -Name ImportExcel -Force
}

$uri="https://www.yammer.com/api/v1/messages.json"

$headers = @{ Authorization=("Bearer " + $developerToken) }

$file = Import-Excel ($BatchFileName + '.xlsx') -HeaderName 'Subject', 'Created By', 'Replies', 'Created', 'Body'

$skipFirst = $true

foreach ($currBody in $file.Body) 
{

    if ($skipFirst -eq $true)
    {
        $skipFirst = $false
        continue
    }

    #Debug Message
    #Write-Host "----- $currBody"
    #break
    
    $body=@{group_id=$groupId;body=$currBody}
 
    Invoke-WebRequest -Uri $uri -Method POST -Headers $headers -Body $body | Out-Null
    Write-Host 'Message Posted on Yammer' -ForegroundColor Green
}