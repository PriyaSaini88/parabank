*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/open_account_page.robot


Suite Setup    Run Keywords    
...    Load Environment
...     AND  Load API Environment
...    AND   Create Api Session
...     AND     Login To Application

Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-HY-01 Create Account via UI and Verify Account Exists in API
    [Documentation]   This test case verifies that an account created on UI is present in API
     Login User
    Go To Open New Account Page
    Enter Account Details    SAVINGS  0
    Verify Account Opened Successfully

    Wait Until Element Is Visible    ${account_no}    20s
    ${ui_id}=    Get Text    ${account_no}


    ${response}=    GET On Session    api_session    /customers/${CUSTOMER_ID}/accounts   
    
    ${body}=    Set Variable    ${response.json()}
    ${account_ids}=    Create List
    FOR    ${account}    IN    @{body}
       ${id}=    Get From Dictionary    ${account}    id
       Append To List    ${account_ids}    ${id}

    END
    
    ${account_id_ui}=  Convert To Integer    ${UI_ID}
    Should Contain    ${account_ids}    ${account_id_ui}






