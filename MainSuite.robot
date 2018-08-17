  *** Settings ***
Library  SeleniumLibrary
#Library   PythonKeywords.py

Force Tags  Unity

Suite Setup  Run Keywords  Open Browser  ${page}  ${browser}
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
@{edit_sdt}     EDIT  RIS  Activity  Questionnaire : 920501013  PageX
@{testbranch}       Cat 1 - Auto   Cat 2 - Auto   Cat 3 - Auto  Cat 4 - Auto  Cat 5 - Auto



*** Test Cases ***
Test SDT Edit
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  SDT  Edit  succeed
    Given Expand Node  @{staticbranch}[0]
    And Element Should Be Visible  xpath: //*[text() = '@{edit_sdt}[0]']
    When Edit SDT   xpath: //*[text() = '@{edit_sdt}[0]']  @{staticbranch}  TEST_EDIT  Edit Test
    Then element should be visible  xpath: //*[text() = 'Edit Test']
    And Edit SDT   xpath: //*[text() = 'Edit Test']  @{staticbranch}  EDIT  @{edit_sdt}[0]


Test Add SDT Root  #Add SDT via root node
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  SDT  Add  succeed
    Given Element Should Be Visible    ${rootnode}
    When Add SDT  ${rootnode}  AUTO_GEN_SDT_ROOT  From Root  @{testbranch}
    Then Expand Node    @{testbranch}[0]
    And Element Should Be Visible   xpath: //*[text() = 'From Root']


Test Remove SDT From Root  #Remove
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  SDT  Remove  succeed
    Given Expand Node  @{testbranch}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Root']
    When Remove SDT   xpath: //*[text() = 'From Root']
    Then element should not be visible   xpath: //*[text() = 'From Root']


Test Add SDT Cat 3  #Add SDT via specified cat 3 node
    #TODO - make less static
    [Documentation]  Should create a new SDT with the context menu from a catagoty 3 node
    [Tags]  SDT  Add  succeed
    Given Expand Node  @{staticbranch}[0]  #Name of parent node
    When Add SDT       xpath: //*[text() = 'Alter']  AUTO_GEN_SDT_CAT3  From Cat 3  @{testbranch}
    Then Expand Node    @{testbranch}[0]
    And Element Should Be Visible   xpath: //*[text() = 'From Cat 3']


Test Remove SDT  #
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  SDT  Remove  succeed
    Given Expand Node  @{testbranch}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Cat 3']
    When Remove SDT   xpath: //*[text() = 'From Cat 3']
    Then element should not be visible   xpath: //*[text() = 'From Cat 3']


Test Add Stage  #Add New Stage
    [Documentation]  Add Stage to Existing branch
    [Tags]  Stage  Add  succeed
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    When Add Stage    xpath: //*[text() = '@{edit_sdt}[0]']    test    @{stage_type}[3]  @{event_publish}[0]
    Then Element Should Be Visible  xpath: //*[text() = '@{stage_type}[3]']

Test Remove Stage
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    When Remove Stage    xpath: //*['@{stage_type}[3]']
    Then Element Should Not Be Visible  xpath: //*[text() = '@{stage_type}[3]']


Test Add Activity
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    When Add Activity  @{edit_sdt}[1]  Auto Activity  @{event_publish}[0]
    Then Element Should Be Visible  xpath: //*[text() = 'Auto Activity']


Test Remove Activity
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    When Remove Activity  xpath: //*['Auto Activity']
    Then Element Should Be Visible  xpath: //*[text() = 'Auto Activity']


Test Add Form
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    When Add Form    xpath: //*[text() = 'ActivityX']
    ${n}=  Get Element Count    xpath: //*[text() = 'Questionnaire :']
    Then Should Be Equal    ${n}    2

Test Remove Form
    Expand Node   @{staticbranch}[0]
    Expand Node    @{edit_sdt}[0]
    @{n}=  Get WebElements  xpath: //*[contains(text(),'Questionnaire :')]
    Log Many     @{n}
    :FOR  ${form} in @{n}
    \
    \   ${form}= Get Text  ${form}
    \   ${t}=  Evaluate    ${form} != "Questionnaire : 920501013"
    \   Run Keyword If    condition    Remove Form    ${form}


*** Keywords ***
Expand Node      # Click on an element by its text
    [Arguments]  ${text}
    click element   xpath: //*[text()= '${text}']
    Sleep    1


Click Confirm   # Click the Save button at the bottom of Add, remove and edit panes
    click button  class: btn-success
    Sleep   1

Click Cancel    # Click the cancel button at the bottom of Add, remove and edit panes
    click button  class: btn-danger
    Sleep   1


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
    [Arguments]  ${node_name}  ${type}
    Item From Context Menu  ${node_name}  Remove ${type}
    Click Confirm

Remove SDT
    [Arguments]  ${node_name}
    Item From Context Menu  ${node_name}  Remove
    Click Confirm


Remove Stage
    [Arguments]  ${node_name}
    Remove Node  ${node_name}  Stage


Remove Activity
    [Arguments]  ${node_name}
    Remove Node  ${node_name}  Activity


Remove Form
    [Arguments]  ${node_name}
    Remove Node  ${node_name}  Form


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
    [Arguments]  ${locator}
    Item From Context Menu  ${locator}  Add new Form
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
    [Arguments]  ${text}  ${text}
    Click Add
    Input Text    id: md-input-atlvwrv0e    ${text}
    Input Text    id: md-input-ieai6brs     ${text}
    Click Save
    Sleep  1

Cancel Property Changes
    Click Button class: md-ripple
    Sleep  1

Click Add
    Click Button  xpath://*[text()="Add"]
    Sleep  1

Click Save
    Click Button  xpath: //*[text()="Save"]
    Sleep  1
