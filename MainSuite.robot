*** Settings ***
Library  SeleniumLibrary
#Library   PythonKeywords.py
Force Tags  Unity
Suite Setup  Run Keywords  Open Browser  ${page}  ${browser}
...             AND           maximize browser window
#...             AND           Set Selenium Speed  0.1
Suite Teardown  Close Browser
Test Setup      Run Keywords  Reload Page
...             AND  Sleep    2


*** Variables ***
@{stage_type}  RESOLVE_IDENTITY  MANAGE_PARTY  CHECK_AND_VALIDATE  DECISION_MAKING  FULFILLMENT  FULFILLMENT_EXECUTION  RIS
@{event_publish}  SELF  ALL  NONE
${browser}      GoogleChrome
${rootnode}     xpath: //*[contains(@id, 'qId_/_')]
@{staticbranch}  D o  Not  Alter  This  Branch
@{edit_sdt}     EDIT  RIS  ActivityX  Questionnaire : 920501285  New page
@{testbranch}       Cat 1 - Auto   Cat 2 - Auto   Cat 3 - Auto  Cat 4 - Auto  Cat 5 - Auto



*** Test Cases ***
Test SDT Edit
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  Unity  SDT  Edit  succeed
    Given Expand Node  @{staticbranch}[0]
    And Element Should Be Visible  xpath: //*[text() = '@{edit_sdt}[0]']
    When Edit SDT   xpath: //*[text() = '@{edit_sdt}[0]']  @{staticbranch}  TEST_EDIT  Edit Test
    Then element should be visible  xpath: //*[text() = 'Edit Test']
    And Edit SDT   xpath: //*[text() = 'Edit Test']  @{staticbranch}  EDIT  @{edit_sdt}[0]


Test Add SDT Root  #Add SDT via root node
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  Unity  SDT  Add  succeed
    Given Element Should Be Visible    ${rootnode}
    When Add SDT  ${rootnode}  AUTO_GEN_SDT_ROOT  From Root  @{testbranch}
    And Sleep    1
    Then Expand Node    @{testbranch}[0]
    And Element Should Be Visible   xpath: //*[text() = 'From Root']


Test Remove SDT From Root  #Remove
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  Unity  SDT  Remove  succeed
    Given Expand Node  @{testbranch}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Root']
    When Remove SDT   xpath: //*[text() = 'From Root']
    Then element should not be visible   xpath: //*[text() = 'From Root']


Test Add SDT Cat 3  #Add SDT via specified cat 3 node
    #TODO - make less static
    [Documentation]  Should create a new SDT with the context menu from a catagoty 3 node
    [Tags]  Unity  SDT  Add  succeed
    Given Expand Node  @{staticbranch}[0]  #Name of parent node
    When Add SDT       xpath: //*[text() = 'Alter']  AUTO_GEN_SDT_CAT3  From Cat 3  @{testbranch}
    Then Expand Node    @{testbranch}[0]
    And Expand Node  @{staticbranch}[0]
    And Element Should Be Visible   xpath: //*[text() = 'From Cat 3']


Test Edit SDT
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  Unity  SDT  Edit  succeed
    Given Expand Node  @{staticbranch}[0]
    And Element Should Be Visible  xpath: //*[text() = '@{edit_sdt}[0]']
    When Edit SDT   xpath: //*[text() = '@{edit_sdt}[0]']  @{staticbranch}  TEST_EDIT  Edit Test
    Then element should be visible  xpath: //*[text() = 'Edit Test']
    And Edit SDT   xpath: //*[text() = 'Edit Test']  @{staticbranch}  EDIT  @{edit_sdt}[0]


Test Remove SDT  #
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  Unity  SDT  Remove  succeed
    Given Expand Node  @{testbranch}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Cat 3']
    When Remove SDT   xpath: //*[text() = 'From Cat 3']
    Then element should not be visible   xpath: //*[text() = 'From Cat 3']


Test Add Stage  #Add New Stage
    [Documentation]  Add Stage to Existing branch
    [Tags]  Unity  Stage  Add  succeed
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    When Add Stage    xpath: //*[text() = '@{edit_sdt}[0]']    test    @{stage_type}[3]  @{event_publish}[0]
    Then Element Should Be Visible  xpath: //*[text() = '@{stage_type}[3]']


Test Edit Stage
    [Documentation]  Should edit Stage values
    [Tags]  Unity  Stage  Edit  succeed
    Expand Node   @{staticbranch}[0]
    Expand Node    @{edit_sdt}[0]
    Edit Stage    xpath: //*[text()="@{edit_sdt}[1]"]   event    ALL
    element should be visible  xpath: //*[text()="@{edit_sdt}[1]"]
    Edit Stage    xpath: //*[text()="@{edit_sdt}[1]"]   Auto    NONE


Test Remove Stage
    [Tags]  Unity
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    When Remove Stage    xpath: //*[text()='@{stage_type}[3]']
    Then Element Should Not Be Visible  xpath: //*[text() = '@{stage_type}[3]']


Test Add Activity
    [Tags]  Unity
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    When Add Activity  xpath: //*[text() = '@{edit_sdt}[1]']  Auto Activity  @{event_publish}[0]
    Then Element Should Be Visible  xpath: //*[text() = 'Auto Activity']


Test Edit Activity
    [Documentation]  Should edit Stage values
    [Tags]  Unity  Stage  Edit  succeed
    Expand Node   @{staticbranch}[0]
    Expand Node    @{edit_sdt}[0]
    Edit Activity   xpath: //*[text()="Auto Activity"]   event    ALL
    Edit Activity   xpath: //*[text()="event"]   Auto Activity    ALL


Test Remove Activity
    [Tags]  Unity
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    When Remove Activity  xpath: //*[text()='Auto Activity']
    Then Element Should not Be Visible  xpath: //*[text() = 'Auto Activity']


Test Add Form
    [Tags]  Unity
    Given Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    When Add Form    xpath: //*[text() = 'ActivityX']


Test Remove Form
    [Tags]  Unity
    Expand Node   @{staticbranch}[0]
    Expand Node    @{edit_sdt}[0]
    ${form_name}=   Get Text    xpath: //*[contains(text(), "Questionnaire :")][last()]
    Remove Form    ${form_name}


Test Add Page
    [Tags]  Unity
    Given Expand Node    @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    ${form_name}=   Get Text    xpath: //*[contains(text(), "Questionnaire :")][last()]
    When Add Page In Unity    xpath: //*[text() = '${form_name}']    Test_New_Page
    Then Element Should Be Visible    xpath: //*[contains(text(),' : Test_New_Page')]


Test Edit Page
    [Documentation]  Should edit Stage values
    [Tags]  Unity  Stage  Edit  succeed
    Expand Node   @{staticbranch}[0]
    Expand Node    @{edit_sdt}[0]
    Edit Page  xpath: //*[text()="@{edit_sdt}"]   event


Open Clarity From Unity
    [Tags]  Unity  Clarity
    Expand Node   @{staticbranch}[0]
    Expand Node    @{edit_sdt}[0]
    ${form_name}=  Get Text    xpath: //*[contains(text(), "Questionnaire :")][last()]
    Open Form In Clarity  xpath: //*[text()="${form_name}"]
    ${title}=  Get Title
    Should Start With    ${title}   Clarity - Forms :


Add controls
    [Tags]  Clarity
    [Template]  Add Control Template
    Alert  alert-control
    Data  data-control
    External Link  externallink-control
    File upload  fileupload-control
    Internal Link  internallink-control
    Key Value List  labelwithtext-control
    Review Card  reviewcard-control
    Rich Message  richmessage-control
    Separator  separator-control
    Spacer  spacer-control



Controls Numberd in Ordered View
    [Tags]  Clarity
    ${before}=  Get Element Count    xpath: //*[contains(@class, "displayOrder")]
    Toggle Ordered View
    ${after}=  Get Element Count    xpath: //*[contains(@class, "displayOrder")]
    Capture Page Screenshot
    Fail If    ${before}!=${after}    Not all controls numbered


Ordered Correctly
    [Tags]  Clarity
    Toggle Ordered View
    @{numbers}=  Get WebElements    xpath: //*[contains(@class, "displayOrder")]
    ${n}=  Set Variable  1
    :FOR  ${number}  IN  @{numbers}
    \   Element Text Should Be    ${number}    ${n}
    \   ${n}=   Evaluate    ${n}+1


Controls Contracted
    [Tags]  Clarity
    ${uncompressed}=  Get Element Count    xpath: //*[contains(@class, "locatorform-group main-question new-control")]
    Toggle Compressed View
    ${compressed}=  Get Element Count    locatorform-group main-question new-control compressed
    Capture Page Screenshot
    Fail If    ${uncompressed}!=${compressed}    Not all controls compressed


Reorder controls
    [Tags]  Clarity
    [Template]  Reorder
    alert-control  data-control
    data-control  externallink-control
    externallink-control  alert-control


Remove Controls
    [Tags]  Clarity
    [Template]  Remove Control
    alert-control
    data-control
    externallink-control
    fileupload-control
    internallink-control
    labelwithtext-control
    reviewcard-control
    richmessage-control
    separator-control
    spacer-control


Add Page in Clarity
    [Tags]  Clarity
    ${pages_before}=  Get Element Count    //*[contains(@class,"md-button md-theme-default")]
    Add Page in Clarity
    ${pages_after}=  Get Element Count    //*[contains(@class,"md-button md-theme-default")]
    Fail If  ${pages_before}+0>=${pages_after}  Page not added.


Delete Page in Clarity
    [Tags]  Clarity
    ${page_count1}=  Get Element Count  //*[contains(@class,"md-button md-theme-default")]
    Element Should Be Visible    class: button-delete-page
    Delete Page in Clarity
    ${page_count2}=  Get Element Count  //*[contains(@class,"md-button md-theme-default")]
    Fail If  ${page_count1}+0<=${page_count2}  Page not deleted.


Open Quesestion Editor
    [Tags] Clarity QEdit
    Click Question Editor Button
    Title Should Be    Clarity - Questions


Add Reference Question


*** Keywords ***
Fail If
    [Arguments]  ${expression}  ${message}
    ${cond}=  Evaluate    ${expression}
    Run Keyword If  ${cond}   Fail  ${message}

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
    Sleep    0.1
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
    Item From Context Menu  ${node_name}  Remove Form
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


Edit Stage
    [Arguments]  ${locator}  ${event}  ${publish}
    Item From Context Menu  ${locator}  Edit Stage
    Select From List By Label   id: PublishEvents  ${publish}
    Input Text    id: EventTypeCode    ${event}
    Click Confirm


Edit Activity
    [Arguments]  ${locator}  ${name}  ${publish}
    Item From Context Menu  ${locator}  Edit Activity
    Input Text    id: EventTypeCode  ${publish}
    Input Text    id: ActivityName    ${name}
    Click Confirm


Edit Page
    [Arguments]  ${locator}  ${name}
    Item From Context Menu  ${locator}  Edit Page
    Input Text    id: PageName    ${name}
    Click Confirm


Add Stage  #Add Stage. Takes SDT node, Event type and 2 drop down indexes
    #TODO
    [Arguments]  ${locator}  ${event}  @{selections}
    Item From Context Menu  ${locator}  Add New Stage
    Select From List By Label    id: StageName  @{selections}[0]
    Select From List By Label    id: PublishEvents  @{selections}[1]
    Input Text    id: EventTypeCode    ${event}
    Click Confirm


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
    Item From Context Menu  ${locator}  Manage Properties


Add Property
    [Arguments]   ${text}  ${text}
    Click Add
    Input Text    xpath:(//*[@class='md-input'])[1]  ${text}
    Input Text    xpath:(//*[@class='md-input'])[2]  ${text}
    Click Save
    Sleep  1

Cancel Property Changes
    Click Button  class="md-ripple"
    Sleep  1

Click Add
    Click Button  class: addBtn
    Sleep  1

Click Save
    Click Button  xpath: //*[@class = "md-button md-dense md-raised md-primary md-theme-default"]
    Sleep  1

Click Cancel Button
    @{elems}=  Get Web Elements  //*[@class = "md-button md-fab md-fab-top-right md-mini cancelButton md-theme-default"]
    Click Button  @{elems}[-1]
    Sleep  1

Open Form In Clarity
    [Arguments]   ${locator}
    Item From Context Menu    ${locator}    Edit in Clarity
    @{windows}=  Get Window Handles
    Select Window  @{windows}[-1]


Open Controls menu
    Click Element   xpath: //*[@class = "md-list-item app-form-controls-section"][2]

Add Control Via Button
    [Arguments]  ${control_name}
    sleep  1
    Mouse Over     //*[text()="${control_name}"]/../..
    Click Element   //*[text()="${control_name}"]/following-sibling::span[@class = "add"]

Add Control Template
    [Arguments]  ${name}  ${id}
    Open Controls menu
    Add Control Via Button  ${name}
    Wait Until Element Is Visible   //*[contains(@class,"${id}")]

Remove Control
    [Arguments]  ${control}
    Mouse Over    xpath: //*[@class="${control}"]
    Wait Until Element Is Visible    xpath: //*[@class="${control}"]/following-sibling::button[@id= "deleteControlButton"]
    Click Button   xpath: //*[@class="${control}"]/following-sibling::button[@id= "deleteControlButton"]
    Sleep    1


Reorder
    [Arguments]  ${locator}  ${target}
    Mouse Over  xpath: //*[@class='${locator}']/*[@class="vddl-handle handle"]
    Sleep  1
    Mouse Down  xpath: //*[@class='${locator}']/*[@class="vddl-handle handle"]
    Mouse Over  xpath: //*[@class='${target}']
    Sleep  1
    Mouse Up    xpath: //*[@class='${target}']


Add Page in Clarity
    Click Button  class: button-add-page
    Sleep  1

Delete Page in Clarity
    Click Button  class: button-delete-page
    Sleep  1

Toggle Compressed View
    Click Button  class: button-compressedmode
    Sleep  1

Toggle Ordered View
    Click Button  class: button-displayorder
    Sleep  1

Open Control Editor
    Click Button  class: fa fa-edit
    Sleep  1

Click Question Editor Button
    Click Button    xpath: //*[@href="#/questions"]


Verity Preview From Clarity
    Click Button  class: fa fa-eye
    Sleep  1

Click New Question
    Click Element    id: newQuestionButton


Add New Reference Question
    Click New Question
