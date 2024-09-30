*** Settings ***
Library           RequestsLibrary

*** Keywords ***
Get API_APP JSON
    [Arguments]    ${num}
    ${resp}=     GET    http://127.0.0.1:5000/is1honor/${num}
    Should Be Equal    ${resp.status_code}    ${200}
    RETURN    ${resp.json()}

Convert String To Boolean
    [Arguments]    ${value}
    ${value} =    Convert To String    ${value}
    ${boolean_value}=    Run Keyword If    '${value}' == 'True'    Set Variable    True
    ...    ELSE    Set Variable    False
    [Return]    ${boolean_value}

*** Test Cases ***
Test API_APP Numbers 3dot6 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:5000/is1honor/3.6
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    ${is1honor}=    Convert String To Boolean    ${json_resp['is1honor']}
    Should Be Equal    ${is1honor}    True

Test API_APP Numbers 2dot0 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:5000/is1honor/2.0
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    ${is1honor}=    Convert String To Boolean    ${json_resp['is1honor']}
    Should Be Equal    ${is1honor}    False

Test API_APP Numbers 5dot1 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:5000/is1honor/5.1
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    Should Be Equal As Strings    ${json_resp['ERROR']}    Invalid input

Test API_APP Numbers 3dot6
    ${json_resp}=    Get API_APP JSON    ${3.6}
    ${is1honor}=    Convert String To Boolean    ${json_resp['is1honor']}
    Should Be Equal    ${is1honor}    True

Test API_APP Numbers 2dot0
    ${json_resp}=    Get API_APP JSON    ${2.0}
    ${is1honor}=    Convert String To Boolean    ${json_resp['is1honor']}
    Should Be Equal    ${is1honor}    False

Test API_APP Numbers 5dot1
    ${json_resp}=    Get API_APP JSON    ${5.1}
    Should Be Equal As Strings    ${json_resp['ERROR']}    Invalid input
