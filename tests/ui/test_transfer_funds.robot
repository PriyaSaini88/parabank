*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/TransferFundPage.robot
Resource    ../../resources/pages/OpenAccountPage.robot


Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application


*** Test Cases ***
TC-TF-UI-01 Verify User Can Transfer Funds Successfully
    [Documentation]    This test case verifies that a user can transfer funds successfully between two different accounts
    Register User Or Login User
    Go To Open New Account Page
    Enter Account Details    SAVINGS  0
    Wait Until Element Is Visible    ${account_no}    20s
    ${account_id_from}=    Get Text    ${account_no}
    
    Go To Open New Account Page
    Enter Account Details    CHECKING  0
    Wait Until Element Is Visible    ${account_no}    20s
    ${account_id_to}=    Get Text    ${account_no}
    
    Go To Transfer Funds Page
    Enter Transfer Details   100  ${account_id_from}   ${account_id_to}
    Click Transfer Button
    Verify Transfer Is Successful


TC-TF-UI-05 Verify User Cannot Transfer Funds without Login
    [Documentation]    This test case verifies that a user cannot transfer funds without login
    Click Element    xpath=//a[contains(text(),'Transfer Funds')]
    Page Should Not Contain Element    ${transfer_fund_page_title}