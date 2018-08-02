*** Keywords ***
Click Text
    [Arguments]  ${nodename}
    click element   Text XPath   ${nodename}

Item From Context Menu
    [Arguments]     ${locator}  ${action}
    open context menu   ${locator}
    Click Text  ${action}

Text XPath
    [Arguments]  ${text}
    [return]  xpath: //*[text() = '${text}']