*** Settings ***
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/keywords/api_keywords.robot
Resource    ../../resources/pages/OpenAccountPage.robot
Resource    ../../resources/pages/TransferFundPage.robot


Suite Setup    Run Keywords    
...    Load Environment
...     AND  Load API Environment
...    AND   Create Api Session
...     AND     Login To Application

Test Setup    Open Application
Test Teardown    Close Application

*** Test Cases ***
Transfer Funds via UI And validate Source Debit And Destination Credit in API
    [Documentation]    This test case verifies that funds transferred via UI is reflected in API with correct debit and credit entries
    Register User Or Login User
    Go To Open New Account Page
    Enter Account Details    SAVINGS  0
    Verify Account Opened Successfully
    Wait Until Element Is Visible    ${account_no}    20s
    ${account_id_from}=    Get Text    ${account_no}
    ${From_Acc_Id}    Convert To Integer    ${account_id_from}
    
    Go To Open New Account Page
    Enter Account Details    CHECKING  0
    Verify Account Opened Successfully
    Wait Until Element Is Visible    ${account_no}    20s
    ${account_id_to}=  Get Text   ${account_no}
    ${To_Acc_Id}    Convert To Integer    ${account_id_to}

    ${initial_balance_from}=  Get Account Balance    ${From_Acc_Id}
    ${initial_balance_to}=  Get Account Balance    ${To_Acc_Id}


    Go To Transfer Funds Page
    Enter Transfer Details   100    ${From_Acc_Id}    ${To_Acc_Id}
    Click Transfer Button
    Verify Transfer Is Successful

    Sleep    5s


    ${final_balance_from}=  Get Account Balance    ${From_Acc_Id}
    ${final_balance_to}=  Get Account Balance    ${To_Acc_Id}

    ${expected_final_balance_from}=  Evaluate    ${initial_balance_from} - 100
    ${expected_final_balance_to}=  Evaluate    ${initial_balance_to} + 100

    Should Be Equal As Numbers    ${final_balance_from}    ${expected_final_balance_from}
    Should Be Equal As Numbers    ${final_balance_to}    ${expected_final_balance_to}


        