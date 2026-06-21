*** Variables ***
${transfer_funds_link}   xpath=//a[@href="transfer.htm"]
${amount_field}   xpath=//input[@id="amount"]
${from_account_dropdown}  xpath=//select[@id="fromAccountId"]
${from_account_option}  xpath=//select[@id="fromAccountId"]/option
${to_account_dropdown}    xpath=//select[@id="toAccountId"]
${to_account_option}    xpath=//select[@id="toAccountId"]/option[1]
${transfer_btn}   xpath=//input[@value="Transfer"]
${transfer_success_msg}   xpath=//h1[contains(text(), 'Transfer Complete!')]
${transfer_fund_page_title}   xpath=//h1[contains(text(), 'Transfer Funds')]
${error_msg}    xpath=//h1[contains(text(), 'Error!')]