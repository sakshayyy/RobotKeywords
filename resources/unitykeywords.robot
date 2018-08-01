*** Keywords ***
Get Visible Nodes
    @{visible}=  create list
    ${nodes}=  find elements  class: node
    :FOR  ${node}  in  @{nodes}
    \   Append To List  @{visable}  get text  ${node}
    [Return]  @{visable}

Remove SDT
    [Arguments]  ${sdt_name}
    open context menu  xpath: //*[text()='${sdt_name}']
    click element  xpath: //*[text()= 'Remove']
    click button  class: btn-ok