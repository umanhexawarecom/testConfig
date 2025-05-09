param($Request)

# Microsoft Teams Webhook 
$webhookurl = 'https://prod-02.centralindia.logic.azure.com:443/workflows/46e7a6337b1340e2bc5add39744bbd0f/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=bOKVzPxwm92OwNC-4GWMHm8x0VbbO5D0D1JeDyUDs_U'
$pipelineID = "1"
$pipelinename = "1"
$workspacename = "1"
$starttime = "1"
$subscriptionID = "1"
$resourceGroup = "1"
$executionStartTime = "1"
$executionDuration = "1"
$executionStatus = "Failed"
$errorMessageMoreInfo = "1"
$errorDetails = "1"
$errorMessage = 'Failed'


$durationinseconds = "1"
$executionEndTime = "1"
$pipelineURL = "1"

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
            "executionMessage"="$Request.body.executionErrorSM"
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


