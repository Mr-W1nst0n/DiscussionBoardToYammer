Clear-Host
Set-Location -Path $PSScriptRoot

# Input Parameters  
$developerToken = Read-Host 'Enter Your Yammer Developer Token' -MaskInput
$groupId= Read-Host 'Input the Encoded Yammer Group'

$uri="https://www.yammer.com/api/v1/messages.json"  

$headers = @{ Authorization=("Bearer " + $developerToken) }  

$htmlBody = "This Message is posted using PowerShell"

$body=@{group_id=$groupId;body=$htmlBody}     
  
# Invoke Web Request  
$webRequest = Invoke-WebRequest -Uri $uri -Method POST -Headers $headers -Body $body  
  
# Check whether the status code is 201 created  
if ($webRequest.StatusCode -eq 201)
{  
    Write-host -ForegroundColor Green "Message posted successfully."     
}  
else
{  
    Write-Host -ForegroundColor Yellow "An error has occurred: " + $webRequest.StatusCode + " Description " + $webRequest.Status  
}