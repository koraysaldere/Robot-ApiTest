*** Settings ***

Library    Collections
Library    requests
Library    RequestsLibrary
Library    OperatingSystem
Library    json
Library    JsonValidator

*** Variables ***  

${json_path}    /home/xlarioth/Paytrek/
${DICTIONARY}   /home/xlarioth/Paytrek/

*** Test Cases ***

I would like to Create a sale via Paytrek ’s Sale API 


    Create Session    dref   https://sandbox.paytrek.com
    ${json_data}   json.dumps   ${DICTIONARY}
    &{headers}  Create Dictionary  Content-Type=application/json
    ${pytrk}  Get Binary File  ${DICTIONARY}data.json
    ${response}    Post Request   dref   /api/v1/sale   data=json${pytrk} headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201


Then, refund this sale via Paytrek ’s Refun API 
    
    ${auth}=  Create List  test_auto   test_auto
    Create Session    ref    https://sandbox.paytrek.com     auth=${auth}   verify=false
    ${resp}=  Post Request  ref  /api/v1/sale/604e52f70b924d678b6b86e9c4d74212/
    Should Be Equal As Strings  ${resp.status_code}  200
    Should Be Equal As Strings  ${resp.json()['authenticated']}  True
   
   
   
   
   
   
   