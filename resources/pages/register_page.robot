*** Settings ***
Library    SeleniumLibrary
Resource    ../../variables/register_page_locators.robot


*** Keywords ***
Go To Register Page
    [Documentation]  Go to the register page
    Click Element    ${register_link}

Fill Registration Details
    [Documentation]    Fill the details of the registration form 
    [Arguments]    ${f_name}   ${l_name}   ${address}  ${city}   ${state}   ${zip_code}  ${phone}   ${ssn}   ${username}  ${pwd}  ${confirm_pwd}

    Wait Until Element Is Visible    ${first_name_field}    10s
    Input Text    ${first_name_field}    ${f_name}

    Input Text    ${last_name_field}    ${l_name}
    Input Text    ${address_field}    ${address}
    Input Text    ${city_field}    ${city}
    Input Text    ${state_field}    ${state}
    Input Text    ${zip_code_field}    ${zip_code}
    Input Text    ${phone_no_field}    ${phone}
    Input Text    ${ssn_input}    ${ssn}
    Input Text    ${username_field}    ${username}
    Input Text    ${password_field}    ${pwd}
    Input Text    ${confirm_pwd_field}    ${confirm_pwd}

Click Register Button
    [Documentation]  Click on the register button to submit the registration form
    Wait Until Element Is Enabled    ${register_btn}    10s
    Click Element    ${register_btn}

Verify Registration is Successful
    [Documentation]  Verify that the registration is successful by checking for a success message or confirmation page
    Wait Until Page Contains Element    ${welcome_msg}    20s


         
    