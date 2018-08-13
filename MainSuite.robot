*** Settings ***
Library   SeleniumLibrary
Library   PythonKeywords.py

Force Tags  Unity

Suite Setup     Run Keywords  Open Browser  ${page}  ${browser}
...             AND           maximize browser window
...             AND           Set Selenium Speed  0.2

Suite Teardown  Close Browser

Test Setup      Sleep         2
Test Teardown   Reload Page


*** Variables ***
${browser}      GoogleChrome
${rootnode}     xpath: //*[contains(@id, 'qId_/_')]
@{staticbranch}  D o  Not  Alter  This  Branch
@{testbranch}       Cat 1 - Auto   Cat 2 - Auto   Cat 3 - Auto  Cat 4 - Auto  Cat 5 - Auto
${uint}          Get Next Int


*** Test Cases ***
Test SDT Edit
    Given Expand Node  @{staticbranch}[0]
    And Element Should Be Visible  xpath: //*[text() = 'Keep Static']
    When Edit SDT   xpath: //*[text() = 'EDIT']  @{staticbranch}  TEST_EDIT  Edit Test
    And Sleep    1
    Then element should not be visible  xpath: //*[text() = 'EDIT']
    And Edit SDT   xpath: //*[text() = 'Edit Test']  @{statbranch}  EDIT  EDIT


Test Add SDT Root  #Add SDT via root node
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  SDT  Add  succeed
    Add SDT  ${rootnode}  AUTO_GEN_SDT_ROOT  From Root
    Sleep    1
    Element Should Be Visible   xpath: //*[text() = 'From Root']


Test Remove SDT From Root
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  SDT  Remove  succeed
    Given Expand Node  @{testbranch}[0]
    And Element Should Be Visible    xpath: //*[text() = 'Auto Gen SDT From Root']
    When Remove SDT   xpath: //*[text() = 'From Root']
    And Sleep    1
    Then element should not be visible   xpath: //*[text() = 'Auto Gen SDT From Root']


Test Add SDT Cat 3  #Add SDT via specified cat 3 node
    #TODO - make less static
    [Documentation]  Should create a new SDT with the context menu from a catagoty 3 node
    [Tags]  SDT  Add  succeed
    Expand Node  @{staticbranch}[0]  #Name of parent node
    Add SDT       xpath: //*[text() = 'Alter']  AUTO_GEN_SDT_CAT3  From Cat 3
    Sleep    1
    Element Should Be Visible   xpath: //*[text() = 'From Cat 3']


Test Remove SDT
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  SDT  Remove  succeed
    Given Expand Node  @{testbranch}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Cat 3']
    When Remove SDT   xpath: //*[text() = 'From Cat 3']
    And Sleep    1
    Then element should not be visible   xpath: //*[text() = 'From Cat 3']



*** Keywords ***
Expand Node      # Click on an element by its text
    [Arguments]  ${text}
    click element   xpath: //*[text()= '${text}']
    Sleep    0.5

Click Confirm   # Click the Save button at the bottom of Add, remove and edit panes
    click button  class: btn-success

Click Cancel    # Click the cancel button at the bottom of Add, remove and edit panes
    click button  class: btn-danger

Item From Context Menu  # Selects the action from the Context menu by text
    [Arguments]     ${locator}  ${action}
    Open Context Menu  ${locator}
    click element   xpath: //*[text()= '${action}']

Text XPath ${text}    # Gets an element by its text attribute
    [return]  xpath: //*[text() = '${text}']

Id XPath ${text}    # Gets an element by a partial id attribute
    [return]  xpath: //*[contains(@id, '${text}')]

Get Visible Nodes  # Get a list of all currently visible nodes
    @{visible}=  create list
    @{nodes}=  find elements  class: node
    :FOR  ${node}  in  @{nodes}
    \   Append To List  @{visable}  get text  ${node}
    [Return]  @{visable}

Fill Form  #takes list of feild ids and text values and inputs the text into the fields
    [Arguments]  @{fields}
    :FOR  ${id}  ${value}  in  @{fields}
    \   input text  ${id}  ${value}

Add SDT  #
    [Arguments]  ${parent}  ${code}  ${text}
    Item From Context Menu  ${parent}  Add New Service Delivery Type
    input text  id: Category1   @{testbranch}[0]
    input text  id: Category2   @{testbranch}[1]
    input text  id: Category3   @{testbranch}[2]
    input text  id: Category4   @{testbranch}[3]
    input text  id: Category5   @{testbranch}[4]
    input text  id: Code        ${code}
    input text  id: Text        ${text}
    Click Confirm

Remove SDT
    [Arguments]  ${sdt_name}
    Item From Context Menu  ${sdt_name}  Remove
    Click Confirm

Edit SDT  #Open the edit menu for SDT make change and save
    [Arguments]  ${locator}  @{input}
    Item From Context Menu    ${locator}  Edit
    input text  id: Category1   @{input}[0]
    input text  id: Category2   @{input}[1]
    input text  id: Category3   @{input}[2]
    input text  id: Category4   @{input}[3]
    input text  id: Category5   @{input}[4]
    input text  id: Code        @{input}[5]
    input text  id: Text        @{input}[6]
    Click Confirm


Add Stage
    #TODO

Edit Stage  ${id} in ${stage}
    Expand Node  ${stage}
    Item From Context Menu  ${id}  Edit

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
