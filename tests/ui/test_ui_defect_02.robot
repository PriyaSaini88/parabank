*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/transfer_fund_page.robot
Resource    ../../resources/pages/open_account_page.robot


Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application


*** Test Cases ***
TC-TF-UI-06 Verify User cannot Transfer Negative Amount
    [Documentation]    It checks the behaviour on transferring any negative amount
    [Tags]    Defect

    Skip    skipping due to BUG-02

    Login User
    Go To Open New Account Page
    Enter Account Details    SAVINGS  0
    Verify Account Opened Successfully


    Wait Until Element Is Visible    ${account_no}    20s
    ${accId_src}=    Get Text    ${account_no}


    Go To Open New Account Page
    Enter Account Details    CHECKING  0
    Verify Account Opened Successfully


    Wait Until Element Is Visible    ${account_no}    20s
    ${accId_dest}=    Get Text    ${account_no}

    Sleep   10s

    Go To Transfer Funds Page
    Enter Transfer Details    -20   ${accId_src}   ${accId_dest}

    Click Transfer Button

    Sleep   5s

    Page Should Not Contain    -$20.00 has been transferred from account #${accId_src} to account #${accId_dest}.

