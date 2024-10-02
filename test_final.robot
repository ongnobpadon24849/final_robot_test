*** Settings ***
Library           RequestsLibrary

*** Keywords ***
Get API_APP JSON
    [Arguments]    ${num}
    ${resp}=     GET    http://127.0.0.1:5000/mul5/${num}
    Should Be Equal    ${resp.status_code}    ${200}
    RETURN    ${resp.json()}

*** Test Cases ***
Test API_APP Numbers 1 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:5000/mul5/1
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['result']}    5

Test API_APP Numbers neg10 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:5000/mul5/-10
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['result']}    -50

Test API_APP Numbers 1dot5 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:5000/mul5/1.5
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal    ${json_resp['result']}    7.5

Test API_APP Numbers 1
    ${json_resp}=    Get API_APP JSON    ${1}
    Should Be Equal    ${json_resp['result']}    5

Test API_APP Numbers neg10
    ${json_resp}=    Get API_APP JSON    ${-10}
    Should Be Equal    ${json_resp['result']}    -50

Test API_APP Numbers 1dot5
    ${json_resp}=    Get API_APP JSON    ${1.5}
    Should Be Equal    ${json_resp['result']}    7.5
