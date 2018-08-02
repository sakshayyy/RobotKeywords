*** Keywords ***
Click Text
    [Arguments]  ${nodename}
    ${nodename}=    Text XPath   ${nodename}
    click element  ${nodename}

Click Confirm
    click button  class: btn-success

Item From Context Menu
    [Arguments]     ${locator}  ${action}
    ${locator}=    Text XPath   ${locator}
    open context menu   ${locator}
    Click Text  ${action}

Text XPath
    [Arguments]  ${text}
    [return]  xpath: //*[text() = '${text}']

