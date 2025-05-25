param($Request)

#$connectionString = $env:AdditionalStorageConnectionString
#$container = "userareacheck/configfiles"
#$blobName = "configteamsalert.csv"

# Use Az module with Shared Key auth (optional)
#$context = New-AzStorageContext -ConnectionString $connectionString

# Download blob to temp path
#$tempFile = Join-Path $env:TEMP $blobName
#Get-AzStorageBlobContent -Container $container -Blob $blobName -Destination $tempFile -Context $context -Force

# Parse CSV
#$data = Import-Csv -Path $tempFile

# Define the value to check against
#$checkValue1 = "Uma"
#$checkValue2 = "Uma-Dev" # Replace with the actual value to check

# Initialize an array to store matching rows
#$matchingRows = @()

# Loop through each row in the CSV
#foreach ($row in $data) {
#    if ($row.workspacename -eq $checkValue1 -and $row.chennailid -eq $checkValue2) { # Replace 'ColumnName' with the actual column name
#        # Add the rest of the column values to the array
#        $matchingRows += $row
#        $subscriptionID = $matchingRows.subscriptionid
#        $resourceGroup = $matchingRows.resourcegroup
#        $pipelineURL = $matchingRows.url
#        $webhookurl = $matchingRows.url
#    }
#}
#Write-Output $subscriptionID
#Write-Output $resourceGroup
#Write-Output $pipelineURL

# Return JSON
#Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
#StatusCode = 200
#Body = ($matchingRows | ConvertTo-Json -Depth 5)
#})


# Microsoft Teams Webhook 
$pipelineID = "1"
$pipelinename = "1"
$workspacename = "Uma"
$chennailid = "Uma-Dev"
$starttime = "1"
$executionStartTime = "1"
$executionDuration = "1"
$executionStatus = "Failed"
$errorMessageMoreInfo = "1"
$errorDetails = "1"
$errorMessage = 'Failed'
$durationinseconds = "1"
$executionEndTime = "1"
$subscriptionID = "1"
$resourceGroup = "1"
$pipelineURL = "1"

$webhookurl = "https://prod-02.centralindia.logic.azure.com:443/workflows/46e7a6337b1340e2bc5add39744bbd0f/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=bOKVzPxwm92OwNC-4GWMHm8x0VbbO5D0D1JeDyUDs_U"




$message =  @{
            "pipelinerunid"="$pipelineID"
            "pipelinename"="$pipelinename"
            "workspacename"="$workspacename"
            "starttime"="$starttime"
            "subscriptionID"="$subscriptionID"
            "resourceGroup"="$resourceGroup"
            "executionStartTime"="$executionStartTime"
            "executionEndTime"="$executionEndTime"
            "executionDuration"="$executionDuration"
            "executionStatus"="$executionStatus"
            "executionDetails"="$errorDetails"
            "executionMessage"="$errorMessageMoreInfo"
            "executionErrorMessage"="$errorMessageMoreInfo"
            "pipelineURL"=$pipelineURL
            }

$jsonMessage = $message | ConvertTo-Json 
Write-Output $jsonMessage

try {
    $response = Invoke-RestMethod -Uri $webhookurl -Method Post -Body $jsonMessage -ContentType "application/json"

    return @{
        status = 200
        body = "Message posted"
    }
}

catch {
    return @{
        status = 500
        body = "Message failed"
    }
}


