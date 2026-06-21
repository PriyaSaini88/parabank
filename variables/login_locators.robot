*** Variables ***
${username_input}   xpath=//input[@name = 'username']
${pwd_input}   xpath=//input[@name = 'password']
${login_btn}   xpath=//input[@value = 'Log In']
${login_success}   xpath=//h1[contains(text(), 'Accounts Overview')]
${logout_link}   xpath=//a[@href = 'logout.htm']
