*** Settings ***
Library  SeleniumLibrary
#Library   PythonKeywords.py
Force Tags  Unity
Suite Setup  Run Keywords  Open Browser  ${PAGE}  ${BROWSER}
...             AND           maximize BROWSER window
#...             AND           Set Selenium Speed  0.1
Suite Teardown  Close Browser
Test Setup      Run Keywords  Reload Page
...             AND  Sleep    2


*** Variables ***
@{STAGE_TYPE}  RESOLVE_IDENTITY  MANAGE_PARTY  CHECK_AND_VALIDATE  DECISION_MAKING  FULFILLMENT  FULFILLMENT_EXECUTION  RIS
@{PUBLISH_EVENT_TYPE}  SELF  ALL  NONE
${BROWSER}      GoogleChrome
${ROOT}     xpath: //*[contains(@id, 'qId_/_')]
@{BASE_BRANCH_CAT}  D o  Not  Alter  This  Branch
@{BASE_BRANCH_NODES}     EDIT  RIS  ActivityX  Questionnaire : 920501285  New page
@{NEW_BRANCH_CAT}         Auto 1    Auto 2    Auto 3    Auto 4    Auto 5



*** Test Cases ***

Test Add SDT Root
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  Unity  SDT  Add
    Given Title Should Be   Unity
    When Element Should Be Visible    ${ROOT}
    And Add SDT  ${ROOT}  AUTO_GEN_SDT_ROOT  From Root  @{NEW_BRANCH_CAT}
    And Sleep    1
    And Expand Node    @{NEW_BRANCH_CAT}[0]
    Then Element Should Be Visible   xpath: //*[text() = 'From Root']


Test Remove SDT From Root
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  Unity  SDT  Remove
    Given Title Should Be   Unity
    When Expand Node  @{NEW_BRANCH_CAT}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Root']
    And Remove SDT   xpath: //*[text() = 'From Root']
    Then element should not be visible   xpath: //*[text() = 'From Root']


Test Add SDT Cat 3   #Add SDT via specified cat 3 node
    #TODO - make less static
    [Documentation]  Should create a new SDT with the context menu from a catagoty 3 node in a different branch
    [Tags]  Unity  SDT  Add
    Given Title Should Be   Unity
    When Expand Node  @{BASE_BRANCH_CAT}[0]  #Name of parent node
    And Add SDT       xpath: //*[text() = 'Alter']  AUTO_GEN_SDT_CAT3  From Cat 3  @{BASE_BRANCH_CAT}
    Then Element Should Be Visible   xpath: //*[text() = 'From Cat 3']


Test Add SDT Cat 3 New Branch   #Add SDT via specified cat 3 node
    #TODO - make less static
    [Documentation]  Should create a new SDT with the context menu from a catagoty 3 node in a different branch
    [Tags]  Unity  SDT  Add
    Given Title Should Be   Unity
    When Expand Node  @{BASE_BRANCH_CAT}[0]  #Name of parent node
    And Add SDT       xpath: //*[text() = 'Alter']  AUTO_GEN_SDT_CAT3_NB  From Cat 3 NB  @{NEW_BRANCH_CAT}
    And Expand Node    @{NEW_BRANCH_CAT}[0]
    And Expand Node  @{BASE_BRANCH_CAT}[0]
    Then Element Should Be Visible   xpath: //*[text() = 'From Cat 3 NB']


Test Edit SDT
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  Unity  SDT  Edit
    Given Title Should Be   Unity
    When Expand Node  @{BASE_BRANCH_CAT}[0]
    And Element Should Be Visible  xpath: //*[text() = '@{BASE_BRANCH_NODES}[0]']
    When Edit SDT   xpath: //*[text() = '@{BASE_BRANCH_NODES}[0]']  @{BASE_BRANCH_CAT}  TEST_EDIT  Edit Test
    Then element should be visible  xpath: //*[text() = 'Edit Test']
    And Edit SDT   xpath: //*[text() = 'Edit Test']  @{BASE_BRANCH_CAT}  EDIT  @{BASE_BRANCH_NODES}[0]


Test Clone SDT To Same Branch
    [Documentation]   Should create a clone SDT from EDIT
    [Tags]  Unity  Clone  SDT
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Clone SDT    xpath: //*[text() = '@{BASE_BRANCH_NODES}[0]']    EDIT_CLONE   Clone Of EDIT  @{BASE_BRANCH_CAT}
    Then Element Should Be Visible   xpath: //*[text() = 'Clone Of EDIT']


Test Clone SDT To New Branch
    [Documentation]   Should create a clone SDT from EDIT under new catagories
    [Tags]  Unity  Clone  SDT
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Clone SDT    xpath: //*[text() = '@{BASE_BRANCH_NODES}[0]']    EDIT_CLONE_NB   Clone Of EDIT NB  @{NEW_BRANCH_CAT}
    And Expand Node    @{NEW_BRANCH_CAT}[0]
    And Expand Node  @{BASE_BRANCH_CAT}[0]
    Then Element Should Be Visible   xpath: //*[text() = 'Clone Of EDIT NB']


Test Remove SDT
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  Unity  SDT  Remove
    [Template]  Remove SDT Template
    From Cat 3          @{BASE_BRANCH_CAT}[0]
    From Cat 3 NB       @{NEW_BRANCH_CAT}[0]
    Clone Of EDIT       @{BASE_BRANCH_CAT}[0]
    Clone Of EDIT NB    @{NEW_BRANCH_CAT}[0]


Test Add Stage  #Add New Stage
    [Documentation]  Add Stage to Existing branch
    [Tags]  Unity  Stage  Add  succeed
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    And Add Stage    xpath: //*[text() = '@{BASE_BRANCH_NODES}[0]']    TEST    @{STAGE_TYPE}[3]  @{PUBLISH_EVENT_TYPE}[0]
    Then Element Should Be Visible  xpath: //*[text() = '@{STAGE_TYPE}[3]']


Test Edit Stage
    [Documentation]  Should edit Stage values
    [Tags]  Unity  Stage  Edit
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    And Edit Stage    xpath: //*[text()="@{BASE_BRANCH_NODES}[1]"]   EVENT    ALL
    Then element should be visible  xpath: //*[text()="@{BASE_BRANCH_NODES}[1]"]


Test Remove Stage
    [Tags]  Unity  Stage  Remove
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    And Remove Stage    xpath: //*[text()='@{STAGE_TYPE}[3]']
    Then Element Should Not Be Visible  xpath: //*[text() = '@{STAGE_TYPE}[3]']


Test Add Activity
    [Tags]  Unity  Add   Activity
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    And Add Activity  xpath: //*[text() = '@{BASE_BRANCH_NODES}[1]']  Auto Activity  @{PUBLISH_EVENT_TYPE}[0]
    Then Element Should Be Visible  xpath: //*[text() = 'Auto Activity']


Test Edit Activity
    [Documentation]  Should edit Stage values
    [Tags]  Unity  Activity  Edit
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    And Edit Activity   xpath: //*[text()="Auto Activity"]   Auto Activity Edit    ALL
    Then Element Should Be Visible  xpath: //*[text() = 'Auto Activity Edit']


Test Remove Activity
    [Tags]  Unity  Activity   Remove
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    And Remove Activity  xpath: //*[text()='Auto Activity Edit']
    Then Element Should not Be Visible  xpath: //*[text() = 'Auto Activity Edit']


Test Add Form
    [Tags]  Unity  Add   Form
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    And Add Form    xpath: //*[text() = 'ActivityX']


Test Remove Form
    [Tags]  Unity   Form  Remove
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    ${form_name}=   Get Text    xpath: (//*[contains(text(), "Questionnaire :")])[1]
    And Remove Form    xpath: //*[text()= "${form_name}"]
    Then Element Should not Be Visible    xpath: //*[text()= "${form_name}"]


Test Add Page
    [Tags]  Unity   Add   Page
    Given Title Should Be   Unity
    When Expand Node    @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    ${form_name}=   Get Text    xpath: //*[contains(text(), "Questionnaire :")][last()]
    And Add Page In Unity    xpath: //*[text() = '${form_name}']    Test_New_Page
    Then Element Should Be Visible    xpath: //*[contains(text(),' : Test_New_Page')]


Test Edit Page
    [Documentation]  Should edit Stage values
    [Tags]  Unity  Page  Edit
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    And Edit Page  xpath: //*[contains(text(),": Test_New_Page")]   Test_New_Page_Edit
    Then Element Should Be Visible  xpath: //*[contains(text(),": Test_New_Page_Edit")]


Open Clarity From Unity
    [Tags]  Unity  Clarity   SwitchPage
    Given Title Should Be   Unity
    When Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    ${form_name}=  Get Text    xpath: //*[contains(text(), "Questionnaire :")][last()]
    And Open Form In Clarity  xpath: //*[text()="${form_name}"]
    Then Clarity Form Should Be Open


Add controls
    [Tags]  Clarity   Control   Add
    [Template]  Add Control Template
    Alert  alert-control
    Data  data-control
    External Link  externallink-control
    File upload  fileupload-control
    Internal Link  internallink-control
    Review Card  reviewcard-control
    Rich Message  richmessage-control
    Separator  separator-control
    Spacer  spacer-control

# Add key/value control
#     [Tags]  Clarity
#     [Template]  Add Control Template
#     Key Value List  labelwithtext-control



Controls Numberd in Ordered View
    [Tags]  Clarity   View
    Given Clarity Form Should Be Open
    ${before}=  Get Element Count    xpath: //*[contains(@class, "displayOrder")]
    When Toggle Ordered View
    ${after}=  Get Element Count    xpath: //*[contains(@class, "displayOrder")]
    Then Capture Page Screenshot
    And Fail If    ${before}!=${after}    Not all controls numbered


Ordered Correctly
    [Tags]  Clarity   View
    Given Clarity Form Should Be Open
    Toggle Ordered View
    @{numbers}=  Get WebElements    xpath: //*[contains(@class, "displayOrder")]
    ${n}=  Set Variable  1
    :FOR  ${number}  IN  @{numbers}
    \   Element Text Should Be    ${number}    ${n}
    \   ${n}=   Evaluate    ${n}+1


Controls Contracted
    [Tags]  Clarity   View
    Given Clarity Form Should Be Open
    ${uncompressed}=  Get Element Count    xpath: //*[contains(@class, "locatorform-group main-question new-control")]
    When Toggle Compressed View
    ${compressed}=  Get Element Count    locatorform-group main-question new-control compressed
    Then Capture Page Screenshot
    And Fail If    ${uncompressed}!=${compressed}    Not all controls compressed

# TODO - Fix reorder
# Reorder controls
#     [Tags]  Clarity
#     [Template]  Reorder
#     data-control  alert-control
#     externallink-control  data-control
#     alert-control  externallink-control


Remove Controls
    [Tags]  Clarity  Remove   Control
    [Template]  Remove Control
    alert-control
    data-control
    externallink-control
    fileupload-control
    internallink-control
    reviewcard-control
    richmessage-control
    separator-control
    spacer-control


Add Page in Clarity
    [Tags]  Clarity  Add   Page
    Given Clarity Form Should Be Open
    ${pages_before}=  Get Element Count    //*[contains(@class,"md-button md-theme-default")]
    When Add Page in Clarity
    ${pages_after}=  Get Element Count    //*[contains(@class,"md-button md-theme-default")]
    Then Fail If  ${pages_before}+0>=${pages_after}  Page not added.


Delete Page in Clarity
    [Tags]  Clarity   Remove   Page
    Given Clarity Form Should Be Open
    ${page_count1}=  Get Element Count  //*[contains(@class,"md-button md-theme-default")]
    Given Element Should Be Visible    class: button-delete-page
    When Delete Page in Clarity
    ${page_count2}=  Get Element Count  //*[contains(@class,"md-button md-theme-default")]
    Then Fail If  ${page_count1}+0<=${page_count2}  Page not deleted.


Open Quesestion Editor
    [Tags]  Clarity   SwitchPage
    Given Clarity Form Should Be Open
    When Click Question Editor Button
    @{windows}=  Get Window Handles
    And Select Window  @{windows}[-1]
    Then Title Should Be    Clarity - Questions


# Add Reference Question
#     [Tags]  Question Editor
#     Given Title Should Be    Clarity - Questions
#     When Add New Reference Question
#     And Fill RefQuestion Type Label    key    label_text    hint_text
#     And Save Question
#     Then Look For Event Success Message


Add Reference Question And Discard
    [Tags]  Question Editor    RefQuestion
    Given Title Should Be    Clarity - Questions
    When Add New Reference Question
    And Fill RefQuestion Type Label    KEY    label_text    hint_text
    And Discard Question Changes
    #Then Look For Event Success Message


Edit Existing Reference Question
    [Tags]  Question Editor    RefQuestion
    Given Title Should Be    Clarity - Questions
    When Search For Question  label_text
    And Click Edit Question
    And Fill RefQuestion Type Label  KEY_TEXT  label_text  hint_text
    And Save Question
    Then Look For Event Success Message


Check if Questions Start compressed
    [Tags]  Question Editor    View
    Given Title Should Be    Clarity - Questions
    When Search For Question  label_text
    Then Element Should Be Visible   xpath: //*[contains(@class," compressed")]




*** Keywords ***
Fail If
    [Arguments]  ${expression}  ${message}
    ${cond}=  Evaluate    ${expression}
    Run Keyword If  ${cond}   Capture Page Screenshot
    Run Keyword If  ${cond}   Fail   ${message}


Expand Node      # Click on an element by its text
    [Arguments]  ${text}
    click element   xpath: //*[text()= '${text}']
    Sleep    1


Good Restricted Input
    [Arguments]  ${locator}   ${input}
    Element Should Be Visible    ${locator}
    Input And Check   ${locator}   ${input}
    Textfield Value Should Be     ${locator}   ${input}


Bad Restricted Input
    [Arguments]  ${locator}   ${input}
    Element Should Be Visible    ${locator}
    Input And Check   ${locator}   ${input}
    Fail If   ${locator}==${input}   Input not correctly restricted


Input And Check
    [Arguments]  ${locator}   ${input}
    Element Should Be Visible    ${locator}
    Input Text    ${locator}   ${input}
    Textfield Value Should Be    ${locator}   ${input}


Click Confirm   # Click the Save button at the bottom of Add, remove and edit panes
    click button   class: btn-success
    Sleep    1


Click Cancel    # Click the cancel button at the bottom of Add, remove and edit panes
    click button  class: btn-danger
    Sleep   0.5


Item From Context Menu  # Selects the action from the Context menu by text
    [Arguments]     ${locator}  ${action}
    Open Context Menu  ${locator}
    Wait Until Element Is Visible    xpath: //*[@class="popup context-menu"]
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
    \   Input And Check  ${id}  ${value}


Add SDT  #
    [Arguments]  ${parent}  ${code}  ${text}  @{Catagories}
    Item From Context Menu  ${parent}  Add New Service Delivery Type
    Input And Check  id: Category1   @{Catagories}[0]
    Input And Check  id: Category2   @{Catagories}[1]
    Input And Check  id: Category3   @{Catagories}[2]
    Input And Check  id: Category4   @{Catagories}[3]
    Input And Check  id: Category5   @{Catagories}[4]
    Input And Check  id: Code        ${code}
    Input And Check  id: Text        ${text}
    Click Confirm


Clone SDT
    [Arguments]  ${parent}  ${code}  ${text}  @{Catagories}
    Item From Context Menu  ${parent}  Clone
    Input And Check  id: Category1   @{Catagories}[0]
    Input And Check  id: Category2   @{Catagories}[1]
    Input And Check  id: Category3   @{Catagories}[2]
    Input And Check  id: Category4   @{Catagories}[3]
    Input And Check  id: Category5   @{Catagories}[4]
    Input And Check  id: Code        ${code}
    Input And Check  id: Text        ${text}
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


Remove SDT Template
    [Arguments]   ${sdt_name}   @{catagories}
    Given Title Should Be   Unity
    :FOR  ${node}  IN  @{catagories}
    \   Expand Node    ${node}
    When Element Should Be Visible    xpath: //*[text() = '${sdt_name}']
    And Remove SDT   xpath: //*[text() = '${sdt_name}']
    Then element should not be visible   xpath: //*[text() = '${sdt_name}']
    And Reload Page
    And Sleep    2


Edit SDT  #Open the edit menu for SDT make change and save
    [Arguments]  ${locator}  @{input}
    Item From Context Menu    ${locator}  Edit
    Input And Check  id: Category1   @{input}[0]
    Input And Check  id: Category2   @{input}[1]
    Input And Check  id: Category3   @{input}[2]
    Input And Check  id: Category4   @{input}[3]
    Input And Check  id: Category5   @{input}[4]
    Input And Check  id: Code        @{input}[5]
    Input And Check  id: Text        @{input}[6]
    Click Confirm


Edit Stage
    [Arguments]  ${locator}  ${event}  ${publish}
    Item From Context Menu  ${locator}  Edit Stage
    Select From List By Label   id: PublishEvents  ${publish}
    Input And Check    id: EventTypeCode    ${event}
    Click Confirm


Edit Activity
    [Arguments]  ${locator}  ${name}  ${publish}
    Item From Context Menu  ${locator}  Edit Activity
    Input And Check    id: EventTypeCode  ${publish}
    Input And Check    id: ActivityName    ${name}
    Click Confirm


Edit Page
    [Arguments]  ${locator}  ${name}
    Item From Context Menu  ${locator}  Edit Page
    Input And Check    id: PageName    ${name}
    Click Confirm


Add Stage  #Add Stage. Takes SDT node, Event type and 2 drop down indexes
    #TODO
    [Arguments]  ${locator}  ${event}  @{selections}
    Item From Context Menu  ${locator}  Add New Stage
    Select From List By Label    id: StageName  @{selections}[0]
    Select From List By Label    id: PublishEvents  @{selections}[1]
    Input And Check    id: EventTypeCode    ${event}
    Click Confirm


Add Activity
    #TODO
    [Arguments]  ${locator}  ${text}  ${event}
    Item From Context Menu  ${locator}  Add New Activity
    Input And Check    id: ActivityName    ${text}
    Input And Check    id: EventTypeCode    ${event}
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
    Input And Check    id: PageName    ${text}
    Click Confirm


Open Properties Manager
    [Arguments]  ${locator}
    Item From Context Menu  ${locator}  Manage Properties


Add Good Property
    [Arguments]   ${text}  ${text}
    Click Add
    Input And Check    xpath:(//*[@class='md-input'])[1]  ${text}
    Input And Check    xpath:(//*[@class='md-input'])[2]  ${text}
    Click Save


Cancel Property Changes
    Click Button  class="md-ripple"
    Sleep  0.5


Click Add
    Click Button  class: addBtn


Click Save
    Click Button  xpath: //*[@class = "md-button md-dense md-raised md-primary md-theme-default"]



Click Cancel Button
    @{elems}=  Get Web Elements  //*[@class = "md-button md-fab md-fab-top-right md-mini cancelButton md-theme-default"]
    Click Button  @{elems}[-1]


Open Form In Clarity
    [Arguments]   ${locator}
    Item From Context Menu    ${locator}    Edit in Clarity
    @{windows}=  Get Window Handles
    Select Window  @{windows}[-1]


Clarity Form Should Be Open
    ${title}=  Get Title
    Should Start With    ${title}   Clarity - Forms :


Open Controls menu
    Click Element   xpath: //*[@class = "md-list-item app-form-controls-section"][2]


Add Control Via Button
    [Arguments]  ${control_name}
    Mouse Over     //*[text()="${control_name}"]/../..
    Wait Until Element Is Visible   //*[text()="${control_name}"]/following-sibling::span[@class = "add"]
    Click Element   //*[text()="${control_name}"]/following-sibling::span[@class = "add"]


Add Control Template
    [Arguments]  ${name}  ${control}
    Given Clarity Form Should Be Open
    ${inital_count}=    Get Element Count    //*[contains(@class,"${control}")]
    When Open Controls menu
    And Add Control Via Button  ${name}
    Then Wait Until Element Is Visible   //*[contains(@class,"${control}")]
    And Look For Event Success Message
    ${final_count}=   Get Element Count    //*[contains(@class,"${control}")]
    And Fail If    ${inital_count}+1!=${final_count}     Control not added correctly


Remove Control
    [Arguments]  ${control}
    Given Clarity Form Should Be Open
    ${inital_count}=    Get Element Count    //*[contains(@class,"${control}")]
    When Mouse Over    xpath: //*[@class="${control}"]
    And Wait Until Element Is Visible    xpath: //*[@class="${control}"]/following-sibling::button[@id= "deleteControlButton"]
    And Click Button   xpath: //*[@class="${control}"]/following-sibling::button[@id= "deleteControlButton"]
    Then Look For Event Success Message
    ${final_count}=   Get Element Count    //*[contains(@class,"${control}")]
    And Fail If    ${inital_count}-1!=${final_count}     Control not removed correctly
    And Close toast message


Reorder
    [Arguments]  ${locator}  ${target}
    Given Clarity Form Should Be Open
    When Mouse Over  xpath: //*[@class='${locator}']/*[@class="vddl-handle handle"]/i
    And Mouse Down  //*[@class='${locator}']/*[@class="vddl-handle handle"]/i
    And Mouse Over   xpath: //*[@class='${target}']
    And Mouse Up    xpath: //*[@class='${target}']
    # TODO - create check to conferm reorder
    #Should Be True    //*



Add Page in Clarity
    Click Button  class: button-add-page
    Look For Event Success Message


Delete Page in Clarity
    Click Button  class: button-delete-page
    Look For Event Success Message


Toggle Compressed View
    Click Button  class: button-compressedmode


Toggle Ordered View
    Click Button  class: button-displayorder


Open Control Editor
    Click Button    class: fa fa-edit


Click Question Editor Button
    Click Link    xpath: //*[@href="#/questions"]


Verity Preview From Clarity
    Click Button  class: fa fa-eye


Click New Question
    Click Element    id: newQuestionButton


Click Edit Question
    Mouse Over    xpath: //*[@class="form-group main-question new-control compressed"]
    Click Element    id: editControlButton


Search For Question
    [Arguments]  ${label}
    Input And Check    xpath: //*[text()="Find by Label"]/following-sibling::input    ${label}
    sleep    0.3
    Wait Until Element Is Not Visible    xpath: //*[@class="spinner"]


Add New Reference Question
    Click New Question
    Wait Until Element Is Visible    xpath: //*[@class="form-group main-question new-control compressed editmode"]


Edit Existing Reference Question
    [Arguments]  ${q_label}  ${key}  ${label}  ${hint}
    Search For Question  ${q_label}
    Fill RefQuestion Type Label  ${key}  ${label}  ${hint}
    Save Question


Fill RefQuestion Type Label
    [Arguments]  ${key}  ${label}  ${hint}
    Select From List By Value  //*[contains(@class, "editmode")]/descendant::select[1]  LABEL
    Input And Check     (//input[@class='fieldinput'])[1]    ${key}
    Input And Check     (//input[@class='fieldinput'])[2]    ${label}
    Input And Check     (//input[@class='fieldinput'])[3]    ${hint}


Save Question
    Click Button    id: doneEditControlButton


Discard Question Changes
    Click Button    id: cancelEditControlButton


Close toast message
    Click Button    class: toast-close-button


Get Event Message
    ${event_text}=  Get Text   xpath: //*[@class="toast-message"]
    [Return]   ${event_text}


Look For Event Success Message
    Wait Until Element Is Visible    class: toast-message
    Element Should Be Visible    xpath: //*[@class="toast toast-success"]


Look For Event Failure Message
    Wait Until Element Is Visible    class: toast-message
    Element Should Be Visible    xpath: //*[@class="toast toast-error"]
