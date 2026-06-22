*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/login_page.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application


*** Test Cases ***
TC-LOG-UI-01 Verify User can Login Successfully
    [Documentation]    This test case verifies that a user can login in successfully with valid credentials.
    Enter Login Details    ${USERNAME}  ${PASSWORD}
    Click Login Button
    Verify Login Is Successful

TC-LOG-UI-02 Verify User Cannot Login with Empty Credentials
    [Documentation]    This test case verifies that a user cannot login with invalid credentials.
    Click Login Button
    Wait Until Page Contains    Please enter a username and password.



