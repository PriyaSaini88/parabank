*** Settings ***
Library     RequestsLibrary
Library     Collections
Library    ../../config/env_loader.py

*** Variables ***
${ENV}  qa


*** Keywords ***
Load API Environment
    [Documentation]    Loads environment configuration
    Load Env    ${ENV}
    ${url}=              Get Env    api_url
    ${username}=         Get Env    api_username
    ${password}=        Get Env    api_password
    ${account_id}=         Get Env    account_id
    

    Set Global Variable    ${API_URL}      ${url}
    Set Global Variable    ${API_USERNAME}  ${username}
    Set Global Variable    ${API_PASSWORD}  ${password}
    Set Global Variable    ${ACCOUNT_ID}    ${account_id}

Create API Session
    [Documentation]    Creates a session for API requests
    ${headers}=  Create Dictionary   Accept=application/json     Content-Type=application/json
    Create Session   api_session   ${API_URL}    headers=${headers}   verify=False


Login To Application
    [Documentation]    Logs into Parabank API and stores session


    ${response}=    Get On Session
    ...   api_session
    ...   /login/${API_USERNAME}/${API_PASSWORD}

    Should Be Equal As Integers    ${response.status_code}    200

    Log To Console    ${response.json()}

    ${body}=  Set Variable  ${response.json()}
    ${customer_id}=  Get From Dictionary    ${body}   id

    Set Global Variable    ${CUSTOMER_ID}    ${customer_id}


Open new Account
    [Documentation]    Opens a new account for the logged-in customer and stores the account ID

    ${params}=    Create Dictionary
    ...    customerId=${CUSTOMER_ID}
    ...    newAccountType=1
    ...    fromAccountId=${ACCOUNT_ID}

    ${response}=    Post On Session
    ...    api_session
    ...    /createAccount
    ...    params=${params}

    Should Be Equal As Integers    ${response.status_code}    200

    Log To Console    ${response.json()}

    ${body}=  Set Variable  ${response.json()}

    ${new_account_id}=  Get From Dictionary    ${body}   id
    ${account_type}=  Get From Dictionary    ${body}   type
    ${account_balance}=  Get From Dictionary    ${body}   balance

    Set Global Variable    ${NEW_ACCOUNT_ID}    ${new_account_id}
    Set Global Variable    ${NEW_ACCOUNT_TYPE}    ${account_type}
    Set Global Variable    ${NEW_ACCOUNT_BALANCE}    ${account_balance}


Transfer Funds
    [Arguments]    ${amount}
    [Documentation]    Transfers funds between two accounts

    ${params}=    Create Dictionary
    ...    fromAccountId=${ACCOUNT_ID}
    ...    toAccountId=${NEW_ACCOUNT_ID}
    ...    amount=${amount}

    ${response}=    Post On Session
    ...    api_session
    ...    /transfer
    ...    params=${params}

    Should Be Equal As Integers    ${response.status_code}    200

Get Account Balance
    [Arguments]    ${accountId}

    ${response}=    GET On Session
    ...    api_session
    ...    /accounts/${accountId}

    Log To Console    ${response.json()}
    ${body}=  Set Variable  ${response.json()}
    ${balance}=  Get From Dictionary    ${body}   balance

    RETURN    ${balance}

