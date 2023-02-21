import urllib.request
import json
import os
import ssl

def allowSelfSignedHttps(allowed):
    # bypass the server certificate verification on client side
    if allowed and not os.environ.get('PYTHONHTTPSVERIFY', '') and getattr(ssl, '_create_unverified_context', None):
        ssl._create_default_https_context = ssl._create_unverified_context

allowSelfSignedHttps(True) # this line is needed if you use self-signed certificate in your scoring service.

# Request data goes here
# The example below assumes JSON formatting which may be updated
# depending on the format your endpoint expects.
# More information can be found here:
# https://docs.microsoft.com/azure/machine-learning/how-to-deploy-advanced-entry-script
data =  {
  "Inputs": {
    "input1": [
      {
        "Col1": "A11",
        "Col2": 6,
        "Col3": "A34",
        "Col4": "A43",
        "Col5": 1169,
        "Col6": "A65",
        "Col7": "A75",
        "Col8": 4,
        "Col9": "A93",
        "Col10": "A101",
        "Col11": 4,
        "Col12": "A121",
        "Col13": 67,
        "Col14": "A143",
        "Col15": "A152",
        "Col16": 2,
        "Col17": "A173",
        "Col18": 1,
        "Col19": "A192",
        "Col20": "A201"
      },
      {
        "Col1": "A12",
        "Col2": 48,
        "Col3": "A32",
        "Col4": "A43",
        "Col5": 5951,
        "Col6": "A61",
        "Col7": "A73",
        "Col8": 2,
        "Col9": "A92",
        "Col10": "A101",
        "Col11": 2,
        "Col12": "A121",
        "Col13": 22,
        "Col14": "A143",
        "Col15": "A152",
        "Col16": 1,
        "Col17": "A173",
        "Col18": 1,
        "Col19": "A191",
        "Col20": "A201"
      },
      {
        "Col1": "A14",
        "Col2": 12,
        "Col3": "A34",
        "Col4": "A46",
        "Col5": 2096,
        "Col6": "A61",
        "Col7": "A74",
        "Col8": 2,
        "Col9": "A93",
        "Col10": "A101",
        "Col11": 3,
        "Col12": "A121",
        "Col13": 49,
        "Col14": "A143",
        "Col15": "A152",
        "Col16": 1,
        "Col17": "A172",
        "Col18": 2,
        "Col19": "A191",
        "Col20": "A201"
      }
    ]
  },
  "GlobalParameters": {
    "Output_path": "output/results_inference.csv"
  }
}

body = str.encode(json.dumps(data))

url = 'http://2c336d87-ce44-4c6e-9620-ec673873cb72.eastus.azurecontainer.io/score'
# Replace this with the primary/secondary key or AMLToken for the endpoint
api_key = 'ZoyGfL4zqE6Ai8ovKSOpCZr6f9cvgVaA'
if not api_key:
    raise Exception("A key should be provided to invoke the endpoint")


headers = {'Content-Type':'application/json', 'Authorization':('Bearer '+ api_key)}

req = urllib.request.Request(url, body, headers)

try:
    response = urllib.request.urlopen(req)

    result = response.read()
    print(result)
except urllib.error.HTTPError as error:
    print("The request failed with status code: " + str(error.code))

    # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
    print(error.info())
    print(error.read().decode("utf8", 'ignore'))