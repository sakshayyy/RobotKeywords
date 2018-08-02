*** Settings ***
Resource  generickeywords.robot

*** Keywords ***
Refresh Unity
    reload page
    sleep   2

Get Visible Nodes
    @{visible}=  create list
    ${nodes}=  find elements  class: node
    :FOR  ${node}  in  @{nodes}
    \   Append To List  @{visable}  get text  ${node}
    [Return]  @{visable}

Fill Form
    [Arguments]  @{fields}
    :FOR  ${id}  ${value}  in  @{fields}
    \   input text  ${id}  ${value}

Add SDT
    [Arguments]  ${parent}  ${code}  ${text}
    Item From Context Menu  ${parent}   Add New Service Delivery Type
    input text  id: Category1   ${branch}[0]
    input text  id: Category2   Cat 2
    input text  id: Category3   Cat 3
    input text  id: Code        AUTO_Root
    input text  id: Text        Auto Gen SDT From Root
    click button  class: btn-save

Remove SDT
    [Arguments]  ${sdt_name}
    open context menu  xpath: //*[text()='${sdt_name}']
    Click Text  Remove
    click button  class: btn-ok