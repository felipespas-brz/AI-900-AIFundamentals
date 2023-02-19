$key="196c7fbc509e4cc19fa29b959f64c972"
$endpoint="https://southcentralus.api.cognitive.microsoft.com/"

# $img = "https://github.com/felipespas-brz/AI-900-AIFundamentals/blob/main/data/vision/Felipe_Andressa.jpg?raw=true"
# $img = "https://github.com/felipespas-brz/AI-900-AIFundamentals/blob/main/data/vision/Felipe_Snowboard.jpg?raw=true"
$img = "https://github.com/felipespas-brz/AI-900-AIFundamentals/blob/main/data/vision/Family.jpg?raw=true"
# $img = "https://github.com/felipespas-brz/AI-900-AIFundamentals/blob/main/data/vision/andressa-snow.jpg?raw=true"

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $key )
$headers.Add( "Content-Type","application/json" )

$body = "{'url' : '$img'}"
$body

write-host "Analyzing image..."
$result = Invoke-RestMethod -Method Post `
          -Uri "$endpoint/vision/v3.2/analyze?visualFeatures=Categories,Description,Objects" `
          -Headers $headers `
          -Body $body | ConvertTo-Json -Depth 5

$analysis = $result | ConvertFrom-Json
Write-Host("`nDescription:")
foreach ($caption in $analysis.description.captions)
{
    Write-Host ($caption.text)
}

Write-Host("`nObjects in this image:")
foreach ($object in $analysis.objects)
{
    Write-Host (" -", $object.object)
}

Write-Host("`nTags relevant to this image:")
foreach ($tag in $analysis.description.tags)
{
    Write-Host (" -", $tag)
}

Write-Host("`n")
