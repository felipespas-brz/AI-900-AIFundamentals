$predictionUrl="https://southcentralus.api.cognitive.microsoft.com/customvision/v3.0/Prediction/50f384d9-1f73-4de0-b4f1-f7e9747964f5/detect/iterations/detect-produce/url"
$predictionKey = "196c7fbc509e4cc19fa29b959f64c972"



# Code to call Custom Vision service for image detection

$img = "https://raw.githubusercontent.com/MicrosoftLearning/AI-900-AIFundamentals/main/data/vision/produce.jpg"

$headers = @{}
$headers.Add( "Prediction-Key", $predictionKey )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"

write-host "Analyzing image..."
$result = Invoke-RestMethod -Method Post `
          -Uri $predictionUrl `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$prediction = $result | ConvertFrom-Json

$items = $prediction.predictions

foreach ($item in $items) 
{if ($item.probability -gt .9)
{
    Write-Host ("`n",$item.tagName, "`n")
}
}

