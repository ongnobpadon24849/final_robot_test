*** Settings ***
Library           RequestsLibrary

*** Keywords ***
Get API_APP JSON
    [Arguments]    ${num}
    ${resp}=     GET    http://127.0.0.1:8080/is_prime/${num}
    Should Be Equal    ${resp.status_code}    ${200}
    RETURN    ${resp.json()}

Convert String To Boolean
    [Arguments]    ${value}
    ${value} =    Convert To String    ${value}
    ${boolean_value}=    Run Keyword If    '${value}' == 'True'    Set Variable    True
    ...    ELSE    Set Variable    False
    [Return]    ${boolean_value}

*** Test Cases ***
Test API_APP Numbers 17 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/is_prime/17
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    ${is_prime}=    Convert String To Boolean    ${json_resp['Is_prime']}
    Should Be Equal    ${is_prime}    True

Test API_APP Numbers 36 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/is_prime/36
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    ${is_prime}=    Convert String To Boolean    ${json_resp['Is_prime']}
    Should Be Equal    ${is_prime}    False

Test API_APP Numbers 13219 (Before Using Keywords)
    ${resp}=     GET    http://127.0.0.1:8080/is_prime/13219
    Should Be Equal    ${resp.status_code}    ${200}
    ${json_resp}=    Set Variable  ${resp.json()}
    ${is_prime}=    Convert String To Boolean    ${json_resp['Is_prime']}
    Should Be Equal    ${is_prime}    True

Test API_APP Numbers 17
    ${json_resp}=    Get API_APP JSON    ${3}
    ${is_prime}=    Convert String To Boolean    ${json_resp['Is_prime']}
    Should Be Equal    ${is_prime}    True

Test API_APP Numbers 36
    ${json_resp}=    Get API_APP JSON    ${8.4}
    ${is_prime}=    Convert String To Boolean    ${json_resp['Is_prime']}
    Should Be Equal    ${is_prime}    False

Test API_APP Numbers 13219
    ${json_resp}=    Get API_APP JSON    ${3}
    ${is_prime}=    Convert String To Boolean    ${json_resp['Is_prime']}
    Should Be Equal    ${is_prime}    True
