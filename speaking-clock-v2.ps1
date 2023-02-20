$key="4c440bf329cc4e599c3ac1e9e20ee8e7"
# $endpoint="https://southcentralus.api.cognitive.microsoft.com/"

$region="southcentralus"


# Code to call Speech to Text API
# $wav = "./data/speech/time.wav"

$wav = "Second-test.wav"

$headers = @{}
$headers.Add( "Ocp-Apim-Subscription-Key", $key )
$headers.Add( "Content-Type","audio/wav" )


write-host "Analyzing audio..."
$result = Invoke-RestMethod -Method Post `
          -Uri "https://$region.stt.speech.microsoft.com/speech/recognition/conversation/cognitiveservices/v1?language=en-US" `
          -Headers $headers `
          -InFile $wav

$analysis = $result
Write-Host ("`nYou said '$($analysis.DisplayText)'")

if ($analysis.DisplayText -eq "What time is it?"){
    # Code to call Text to Speech API
    $sml = "<speak version='1.0' xml:lang='en-US'>
    <voice xml:lang='en-US' xml:gender='Female' name='en-US-AriaNeural'>
        Hi Felipe! How are you? It's coding time!
    </voice>
    </speak>"

    $headers = @{}
    $headers.Add( "Ocp-Apim-Subscription-Key", $key )
    $headers.Add( "Content-Type","application/ssml+xml" )
    $headers.Add( "X-Microsoft-OutputFormat","audio-16khz-128kbitrate-mono-mp3" )

    $outputFile = "output_3.wav"

    write-host "Synthesizing speech..."
    $result = Invoke-RestMethod -Method Post `
        -Uri "https://$region.tts.speech.microsoft.com/cognitiveservices/v1" `
        -Headers $headers `
        -Body $sml `
        -OutFile $outputFile

    write-host $result
    write-host "Response saved in $outputFile `n"

}