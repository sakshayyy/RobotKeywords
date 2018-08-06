*** Settings ***
Resource  generickeywords.robot
Resource  variables.robot

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
    input text  id: Category1   @{branch}[0]
    input text  id: Category2   @{branch}[1]
    input text  id: Category3   @{branch}[2]
    input text  id: Code        ${code}
    input text  id: Text        ${text}
    Click Confirm

Remove SDT
    [Arguments]  ${sdt_name}
    open context menu  xpath: //*[text()='${sdt_name}']
    Click Text  Remove
    Click Confirm

Edit SDT
    #TODO

Add Stage
    #TODO

Edit Stage
    #TODO

Remove Stage
    #TODO

Add Activity
    #TODO

Add Form
    #TODO

Add Page In Unity
    #TODO

Open Properties Manager For
    #TODO

Manage properties
    #TODO