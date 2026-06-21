*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/TransferFundPage.robot
Resource    ../../resources/pages/OpenAccountPage.robot


Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application


*** Test Cases ***
TC-TF-UI-05 Verify User cannot Transfer zero amount
    [Documentation]    It checks the behaviour on transferring zero amount
    [Tags]    Defect

    Skip    Skipping the case because of BUG-01
    
     Login User
    Go To Open New Account Page
    Enter Account Details    SAVINGS  0
    Verify Account Opened Successfully

    Wait Until Element Is Visible    ${account_no}    20s
    ${accId_from}=    Get Text    ${account_no}



    Go To Open New Account Page
    Enter Account Details    CHECKING  0
    Verify Account Opened Successfully

    Wait Until Element Is Visible    ${account_no}    20s
    ${accId_to}=    Get Text    ${account_no}

    Sleep   5s

    Go To Transfer Funds Page
    Enter Transfer Details    0   ${accId_from}   ${accId_to}

    Click Transfer Button


    Sleep   5s

    Page Should Not Contain    $0.00 has been transferred from account #${accId_from} to account #${accId_to}






    
    