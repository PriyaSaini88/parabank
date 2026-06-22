*** Settings ***
Library    SeleniumLibrary
Resource   ../../variables/login_locators.robot

*** Keywords ***
Enter Login Details
    [Documentation]  Enter the login details of the user
    [Arguments]    ${username}  ${pwd}

    Wait Until Element Is Visible    ${username_input}  timeout=10s
    Input Text    ${username_input}  ${username}
    Input Text    ${pwd_input}  ${pwd}

Click Login Button
    Wait Until Element Is Enabled    ${login_btn}  timeout=15s
    Click Button  ${login_btn}

Verify Login Is Successful
    [Documentation]  Verify that the login is successful by checking for a specific element or message on the homepage
    Wait Until Page Contains Element    ${login_success}    timeout=20s