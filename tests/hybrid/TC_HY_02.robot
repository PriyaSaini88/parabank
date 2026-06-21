*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/OpenAccountPage.robot


Suite Setup    Run Keywords
...    Load Environment
...     AND  Load API Environment
...    AND   Create Api Session
...     AND     Login To Application

Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-HY-02 Create Account via UI and Validate Type and Balance Match in API
    [Documentation]   This test case verifies that an account created on UI is present in API
    Login User
    Go To Open New Account Page
    Enter Account Details    CHECKING  0
    Verify Account Opened Successfully

     Wait Until Element Is Visible    ${account_no}    20s
    ${ui_id}=    Get Text    ${account_no}

    ${response}=    GET On Session    api_session    /accounts/${ui_id}

    Should Be Equal As Strings    ${response.status_code}    200
    ${body}=   Set Variable   ${response.json()}
    
    ${api_account_type}=   Get From Dictionary   ${body}   type
    ${api_account_balance}=   Get From Dictionary   ${body}   balance

    Should Be Equal As Strings    ${api_account_type}    CHECKING
    Should Be True   ${api_account_balance} >= 0
