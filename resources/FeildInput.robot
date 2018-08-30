*** Settings ***
Library  DateTime
Library  SeleniumLibrary

*** keywords ***
Checked input
    [Arguments]   ${locator}    ${text}
    Input Text    ${locator}    ${text}
    Textfield Value Should Be    ${locator}    ${text}


Input unique number into ${locator}
    ${text}=    Get Current Date    result_format=epoch
    Input Text    ${locator}    ${text}
