$predictionUrl="https://southcentralus.api.cognitive.microsoft.com/customvision/v3.0/Prediction/3b7ec5ee-2187-4c6c-b8ab-e2e5b3b11a6b/classify/iterations/groceries/url"
$predictionKey = "7e2aa5360eeb430da856a4386d42438b"

$img = "https://github.com/felipespas-brz/AI-900-AIFundamentals/blob/main/training-images/new-apple.jpg?raw=true"

$headers = @{}
$headers.Add( "Prediction-Key", $predictionKey )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"
$body

write-host "Analyzing image..."
$result = Invoke-RestMethod -Method Post `
          -Uri $predictionUrl `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$prediction = $result | ConvertFrom-Json

Write-Host ("`n",$prediction.predictions[0].tagName, "`n")
