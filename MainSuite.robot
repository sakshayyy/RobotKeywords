*** Settings ***
Library   SeleniumLibrary
#Library   PythonKeywords.py

Force Tags  Unity

Suite Setup     Run Keywords  Open Browser  ${page}  ${browser}
...             AND           maximize browser window
#...             AND           Set Selenium Speed  0.1

Suite Teardown  Close Browser

Test Setup      Sleep         2

Test Teardown   Reload Page


*** Variables ***
@{stage_type}  RESOLVE_IDENTITY  MANAGE_PARTY  CHECK_AND_VALIDATE  DECISION_MAKING  FULFILLMENT  FULFILLMENT_EXECUTION  RIS
@{event_publish}  SELF  ALL  NONE
${browser}      GoogleChrome
${rootnode}     xpath: //*[contains(@id, 'qId_/_')]
@{staticbranch}  D o  Not  Alter  This  Branch
${editsdt}     EDIT
@{testbranch}       Cat 1 - Auto   Cat 2 - Auto   Cat 3 - Auto  Cat 4 - Auto  Cat 5 - Auto



*** Test Cases ***
Test SDT Edit
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  SDT  Edit  succeed
    Given Expand Node  @{staticbranch}[0]
    And Element Should Be Visible  xpath: //*[text() = '${editsdt}']
    When Edit SDT   xpath: //*[text() = '${editsdt}']  @{staticbranch}  TEST_EDIT  Edit Test
    And Sleep    1
    Then element should be visible  xpath: //*[text() = 'Edit Test']
    And Edit SDT   xpath: //*[text() = 'Edit Test']  @{staticbranch}  EDIT  ${editsdt}


Test Add SDT Root  #Add SDT via root node
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  SDT  Add  succeed
    Given Element Should Be Visible    ${rootnode}
    When Add SDT  ${rootnode}  AUTO_GEN_SDT_ROOT  From Root  @{testbranch}
    And Sleep    1
    Then Expand Node    @{testbranch}[0]
    And Element Should Be Visible   xpath: //*[text() = 'From Root']


Test Remove SDT From Root  #Remove
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  SDT  Remove  succeed
    Given Expand Node  @{testbranch}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Root']
    When Remove Node   xpath: //*[text() = 'From Root']
    And Sleep    1
    Then element should not be visible   xpath: //*[text() = 'From Root']


Test Add SDT Cat 3  #Add SDT via specified cat 3 node
    #TODO - make less static
    [Documentation]  Should create a new SDT with the context menu from a catagoty 3 node
    [Tags]  SDT  Add  succeed
    Given Expand Node  @{staticbranch}[0]  #Name of parent node
    When Add SDT       xpath: //*[text() = 'Alter']  AUTO_GEN_SDT_CAT3  From Cat 3  @{testbranch}
    And Sleep    1
    Then Element Should Be Visible   xpath: //*[text() = 'From Cat 3']


Test Remove SDT  #
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  SDT  Remove  succeed
    Given Expand Node  @{testbranch}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Cat 3']
    When Remove Node   xpath: //*[text() = 'From Cat 3']
    And Sleep    1
    Then element should not be visible   xpath: //*[text() = 'From Cat 3']


Test Add Stage  #Add New Stage
    [Documentation]  Add Stage to Existing branch
    [Tags]  Stage  Add  succeed
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    ${editsdt}
    When Add Stage    xpath: //*[text() = '${editsdt}']    test    @{stage_type}[4]  @{event_publish}[0]
    Then Element Should Be Visible  xpath: //*[text() = '@{stage_type}[4]']


Test Add Activity
    Add Activity  @{stage_type}[4]  Auto Activity  @{event_publish}[0]


Test Full Suite
    Expand Node    @{staticbranch}[0]
    Add SDT    @{staticbranch}[2]    FULL    FULL  @{staticbranch}
    Expand Node    FULL
    Add Stage    xpath: //*[text() = 'Keep Static']    text    0  0



*** Keywords ***
Expand Node      # Click on an element by its text
    [Arguments]  ${text}
    click element   xpath: //*[text()= '${text}']
    Sleep    1


Click Confirm   # Click the Save button at the bottom of Add, remove and edit panes
    click button  class: btn-success
    Sleep   0.5

Click Cancel    # Click the cancel button at the bottom of Add, remove and edit panes
    click button  class: btn-danger
    Sleep   0.5


Item From Context Menu  # Selects the action from the Context menu by text
    [Arguments]     ${locator}  ${action}
    Open Context Menu  ${locator}
    click element   xpath: //*[text()= '${action}']
    sleep  1


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


Fill Text Form  #takes list of feild ids and text values and inputs the text into the fields
    [Arguments]  @{fields}
    :FOR  ${id}  ${value}  in  @{fields}
    \   input text  ${id}  ${value}


Add SDT  #
    [Arguments]  ${parent}  ${code}  ${text}  @{Catagories}
    Item From Context Menu  ${parent}  Add New Service Delivery Type
    input text  id: Category1   @{Catagories}[0]
    input text  id: Category2   @{Catagories}[1]
    input text  id: Category3   @{Catagories}[2]
    input text  id: Category4   @{Catagories}[3]
    input text  id: Category5   @{Catagories}[4]
    input text  id: Code        ${code}
    input text  id: Text        ${text}
    Click Confirm

Remove Node  # Generic Remove
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


Add Stage  #Add Stage. Takes SDT node, Event type and 2 drop down indexes
    #TODO
    [Arguments]  ${locator}  ${event}  @{selections}
    Item From Context Menu  ${locator}  Add New Stage
    Select From List By Label    id: StageName  @{selections}[0]
    Select From List By Label    id: PublishEvents  @{selections}[1]
    Input Text    id: EventTypeCode    ${event}
    Click Confirm


Edit Stage
    [Arguments]  ${locator}
    Item From Context Menu  ${locator}  Edit



Add Activity
    #TODO
    [Arguments]  ${locator}  ${text}  ${event}
    Item From Context Menu  ${locator}  Add New Activity
    Input Text    id: ActivityName    ${text}
    Input Text    id: EventTypeCode    ${event}
    Click Confirm


Add Form
    #TODO
    [Arguments]  ${locator}  ${text}
    Item From Context Menu  ${locator}  Add New Form
    Click Confirm



Add Page In Unity
    #TODO
    [Arguments]  ${locator}  ${text}
    Item From Context Menu  ${locator}  Add New Page
    Input Text    id: PageName    ${text}
    Click Confirm


Open Properties Manager
    [Arguments]  ${locator}
    Item From Context Menu  ${locator}  Edit Properties


Add Property
    #TODO
