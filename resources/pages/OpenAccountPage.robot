*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/variables/open_account_locators.robot

*** Keywords ***
Go To Open New Account Page
    [Documentation]    Click on Open New Account
    Click Element    ${open_account_link}

Enter Account Details
    [Documentation]    Select account type and from account
    [Arguments]    ${account_type}    ${from_account_index}

    Wait Until Element Is Visible    ${account_type_dropdown}    10s
    Select From List By Label     ${account_type_dropdown}    ${account_type}


    Wait Until Page Contains Element   ${from_account_option}    15s
    Select From List By Index     ${from_account}    ${from_account_index}

    Click Element    ${open_new_account_btn}

Verify Account Opened Successfully
    [Documentation]    Verify that the account is opened successfully
    Wait Until Page Contains Element  ${success_msg}    20s


