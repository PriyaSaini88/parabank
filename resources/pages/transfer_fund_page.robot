*** Settings ***
Library    SeleniumLibrary
Resource    ../../variables/transfer_funds_locators.robot


*** Keywords ***
Go To Transfer Funds Page
    [Documentation]    Click on Transfer Funds link 
    Click Element    ${transfer_funds_link}
    
Enter Transfer Details 
    [Documentation]    Enter details such as amount and accounts to transfer funds
    [Arguments]    ${amount_to_transfer}  ${from_account_id}  ${to_account_id}
    Wait Until Element Is Visible    ${amount_field}    10s
    Input Text    ${amount_field}    ${amount_to_transfer}

    Wait Until Page Contains Element   ${from_account_option}    15s
    Select From List By Value     ${from_account_dropdown}    ${from_account_id}

    Wait Until Page Contains Element   ${to_account_option}    15s
    Select From List By Value         ${to_account_dropdown}    ${to_account_id}

Click Transfer Button
    [Documentation]    Click on the transfer button
    Click Element    ${transfer_btn}

Verify Transfer is Successful
    [Documentation]    Verify that the transfer is successful
    Wait Until Page Contains Element    ${transfer_success_msg}    20s

