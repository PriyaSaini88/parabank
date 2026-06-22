*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/register_page.robot

Suite Setup    Load Environment
Test Setup    Open Application
Test Teardown    Close Application


*** Test Cases ***
TC-REG-UI-01 Verify User Can Register Successfully
    [Documentation]  This test case verifies that a user can register successfully.
    Go To Register Page
    Fill Registration Details    ab    cd    123jk    jk    raj   12345    1234567890   123   abcd   cdef   cdef
    Click Register Button
    Verify Registration Is Successful

TC-REG-UI-02 Verify User Cannot Register with Empty Fields
    [Documentation]  This test case verifies that a user cannot register with empty fields.
    Go To Register Page
    Click Register Button
    Wait Until Page Contains    First name is required.
