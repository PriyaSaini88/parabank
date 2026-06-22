*** Settings ***
Library    RequestsLibrary
Library    Collections
Resource    ../../resources/keywords/api_keywords.robot

Suite Setup      Run Keywords
...    Load API Environment
...     AND   Create Api Session
...     AND     Login To Application
...     AND   Open new Account

*** Variables ***
${transfer_amount}=  100

*** Test Cases ***
TC-API-01 Get All Accounts By Customer ID
    [Documentation]    It returns all accounts for customer id

    ${response}=  GET On Session    api_session   /customers/${CUSTOMER_ID}/accounts
    
    Should Be Equal As Integers    ${response.status_code}   200
    
    ${body}=  Set Variable   ${response.json()}

    Log To Console   ${body}
    
    ${first_account}=  Get From List      ${body}   0
    
    ${fetched_customerId}=  Get From Dictionary    ${first_account}  customerId
    
    Should Be Equal As Integers    ${fetched_customerId}   ${CUSTOMER_ID}

    
TC-API-02 Get Account BY account id
    [Documentation]   It return account with given account id

    ${response}=   GET On Session  api_session   /accounts/${NEW_ACCOUNT_ID}

    Should Be Equal As Integers    ${response.status_code}    200

    Log To Console    ${response.json()}

    ${body}=  Set Variable  ${response.json()}
    
    ${fetched_id}=   Get From Dictionary    ${body}   id
    Should Be Equal As Strings    ${fetched_id}    ${NEW_ACCOUNT_ID}



TC-API-03 Verify Get Accounts Response is Not Empty
    [Documentation]    It checks the response array is not empty

    ${response}=   GET On Session  api_session   /accounts/${NEW_ACCOUNT_ID}

    Should Be Equal As Integers    ${response.status_code}   200
    
    ${response_time}=   Evaluate    $response.elapsed.total_seconds() * 1000
    Should Be True    ${response_time} < 3000
    
    Should Not Be Empty    ${response.json()}


TC-API-04 Wrong Customer id returns error
    [Documentation]   it verify that wrong customer id return error

    ${response}=  GET On Session   api_session   /customers/999999/accounts  expected_status=any

    Should Be Equal As Integers    ${response.status_code}    400


TC-API-05 Verify Account Balance after Transfer Debit Equals to Credit
    [Documentation]  It verifies that the account balance after transfer

    ${initial_balance_from}=  Get Account Balance    ${ACCOUNT_ID}
    ${initial_balance_to}=  Get Account Balance    ${NEW_ACCOUNT_ID}


    Transfer Funds    ${transfer_amount}

    Sleep    5s

    ${final_balance_from}=  Get Account Balance    ${ACCOUNT_ID}
    ${final_balance_to}=  Get Account Balance    ${NEW_ACCOUNT_ID}


    ${expected_final_balance_from}=  Evaluate     ${initial_balance_from} - ${transfer_amount}
    ${expected_final_balance_to}=  Evaluate    ${initial_balance_to} + ${transfer_amount}

    Should Be Equal As Numbers    ${final_balance_from}    ${expected_final_balance_from}
    Should Be Equal As Numbers    ${final_balance_to}    ${expected_final_balance_to}










  


    