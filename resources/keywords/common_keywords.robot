*** Settings ***
Library    SeleniumLibrary
Library    ../../config/env_loader.py
Resource    ../../resources/pages/login_page.robot



*** Variables ***
${BROWSER}  chrome
${ENV}  qa

*** Keywords ***
Load Environment
    [Documentation]    Loads environment configuration
    Load Env    ${ENV}
    ${url}=              Get Env    baseurl
    ${username}=     Get Env    username
    ${password}=     Get Env    password

    Set Global Variable    ${BASE_URL}      ${url}
    Set Global Variable    ${USERNAME}      ${username}
    Set Global Variable    ${PASSWORD}      ${password}

Open Application
    [Documentation]  Opening the application
    Open Browser  ${BASE_URL}  ${BROWSER}
    Maximize Browser Window

Close Application
    [Documentation]  Closing the application
    Close All Browsers

Login User
    [Documentation]    It registers the user if login is fail
    Enter Login Details    ${USERNAME}  ${PASSWORD}
    Click Login Button
    
#    ${login_success}=    Run Keyword And Return Status    Verify Login Is Successful
#    IF    '${login_success}' == 'False'
#        Go To Register Page
#        Fill Registration Details    abc    cd    123jk    jk    raj   12345    1234567890   123   abc  cdef   cdef
#        Click Register Button
#        Verify Registration Is Successful
#        Click Element    ${logout_link}
#        Enter Login Details    abc   cdef
#        Click Login Button
#        Verify Login Is Successful
#    END

    
