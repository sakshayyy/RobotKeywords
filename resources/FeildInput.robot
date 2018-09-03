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


Good Restricted Input
    [Arguments]  ${locator}   ${input}
    Element Should Be Visible    ${locator}
    Checked input   ${locator}   ${input}
    Textfield Value Should Be     ${locator}   ${input}


Bad Restricted Input
    [Arguments]  ${locator}   ${input}
    Element Should Be Visible    ${locator}
    Input Text   ${locator}   ${input}
    ${field_value}=    Get Value    ${locator}
    Fail If   ${locator}==${input}   Input not correctly restricted
