$key="4c440bf329cc4e599c3ac1e9e20ee8e7"
$endpoint="https://southcentralus.api.cognitive.microsoft.com/"

# $img = "https://raw.githubusercontent.com/MicrosoftLearning/AI-900-AIFundamentals/main/data/vision/$img_file"
# $img = "https://github.com/felipespas-brz/AI-900-AIFundamentals/blob/main/data/vision/store-camera-1.jpg?raw=true"
$img = "https://github.com/felipespas-brz/AI-900-AIFundamentals/blob/main/data/vision/Felipe_Andressa.jpg?raw=true"

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $key )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"
$body

write-host "Analyzing image...`n"
$result = Invoke-RestMethod -Method Post `
          -Uri "$endpoint/face/v1.0/detect?detectionModel=detection_01" `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$analysis = ($result | ConvertFrom-Json)

# Write-Host ("`nFrom June 21st 2022, Face service capabilities that return personally identifiable features are restricted.`nSee https://azure.microsoft.com/blog/responsible-ai-investments-and-safeguards-for-facial-recognition/ for details.`nThis code is restricted to returning the location of any faces detected:`n")

foreach ($face in $analysis)
{
    Write-Host("Face location: $($face.faceRectangle)`n")
}

