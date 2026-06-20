*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/OpenAccountPage.robot


Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
TC-AC-UI-01 Verify User Can Open Savings Account Successfully
    [Documentation]    This verifies that a user can open a savings account successfully
    Register User Or Login User
    Go To Open New Account Page
    Enter Account Details    SAVINGS  0
    Verify Account Opened Successfully


TC-AC-UI-02 Verify User Can Open Checking Account Successfully
    [Documentation]    This verifies that a user can open a checking account successfully
    Register User Or Login User
    Go To Open New Account Page
    Enter Account Details    CHECKING  0
    Verify Account Opened Successfully



