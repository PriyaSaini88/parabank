*** Variables ***
${open_account_link}   xpath=//a[@href="openaccount.htm"]
${account_type_dropdown}   xpath=//select[@id="type"]
${from_account}   xpath=//select[@id="fromAccountId"]
${from_account_option}   xpath=//select[@id="fromAccountId"]/option
${open_new_account_btn}   xpath=//input[@value="Open New Account"]
${success_msg}   xpath=//h1[contains(text(), 'Account Opened!')]
${account_no}   xpath=//a[@id="newAccountId"]