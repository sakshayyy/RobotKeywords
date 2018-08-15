*** Settings ***
Documentation  This file is for keywords that can be used throughout the testing of ACT

*** Keywords ***
Click Text      # Click on an element by its text
    [Arguments]  ${nodename}
    ${nodename}=    Text XPath ${nodename}
    click element  ${nodename}

Click Confirm   # Click the Save button at the bottom of Add, remove and edit panes
    click button  class: btn-success

Click Cancel    # Click the cancel button at the bottom of Add, remove and edit panes
    click button  class: btn-danger

Item From Context Menu  # Selects the action from the Context menu by text
    [Arguments]     ${locator}  ${action}
    ${locator}=    Text XPath ${locator}
    open context menu   ${locator}
    Click Text  ${action}

Text XPath ${text}    # Gets an element by its text attribute
    [return]  xpath: //*[text() = '${text}']
