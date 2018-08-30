*** Settings ***
Library   SeleniumLibrary
Resource    ACT_Variables.robot
Resource    FeildInput.robot

Force Tags  Unity

Suite Setup  Run Keywords
...          Open Browser  ${page}  ${browser}
...          AND           maximize browser window

Suite Teardown  Close Browser
Test Setup      Sleep         2
Test Teardown   Reload Page


*** Test Cases ***

Test Add SDT Root
    [Documentation]   Create a new SDT with the context menu from Root
    [Tags]  SDT  Add  succeed
    Given Element Should Be Visible    ${ROOT}
    When Add SDT  ${ROOT}  AUTO_GEN_SDT_ROOT  From Root  @{NEW_BRANCH_CAT}
    And Sleep    1
    Then Expand Node    @{NEW_BRANCH_CAT}[0]
    And Element Should Be Visible   xpath: //*[text() = 'From Root']


Test Remove SDT From Root  #Remove
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  SDT  Remove  succeed
    Given Expand Node  @{NEW_BRANCH_CAT}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Root']
    When Remove SDT   xpath: //*[text() = 'From Root']
    Then element should not be visible   xpath: //*[text() = 'From Root']


Test Add SDT Cat 3  #Add SDT via specified cat 3 node
    #TODO - make less static
    [Documentation]  Should create a new SDT with the context menu from a catagoty 3 node
    [Tags]  SDT  Add  succeed
    Given Expand Node  @{BASE_BRANCH_CAT}[0]  #Name of parent node
    When Add SDT       xpath: //*[text() = 'Alter']  AUTO_GEN_SDT_CAT3  From Cat 3  @{NEW_BRANCH_CAT}
    Then Expand Node    @{NEW_BRANCH_CAT}[0]
    And Expand Node  @{BASE_BRANCH_CAT}[0]
    And Element Should Be Visible   xpath: //*[text() = 'From Cat 3']


Test Edit SDT
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  SDT  Edit  succeed
    Given Expand Node  @{BASE_BRANCH_CAT}[0]
    And Element Should Be Visible  xpath: //*[text() = '@{BASE_BRANCH_NODES}[0]']
    When Edit SDT   xpath: //*[text() = '@{BASE_BRANCH_NODES}[0]']  @{BASE_BRANCH_CAT}  TEST_EDIT  Edit Test
    Then element should be visible  xpath: //*[text() = 'Edit Test']
    And Edit SDT   xpath: //*[text() = 'Edit Test']  @{BASE_BRANCH_CAT}  EDIT  @{BASE_BRANCH_NODES}[0]


Test Remove SDT  #
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  SDT  Remove  succeed
    Given Expand Node  @{NEW_BRANCH_CAT}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Cat 3']
    When Remove SDT   xpath: //*[text() = 'From Cat 3']
    Then element should not be visible   xpath: //*[text() = 'From Cat 3']


Test Add Stage  #Add New Stage
    [Documentation]  Add Stage to Existing branch
    [Tags]  Stage  Add  succeed
    Given Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    When Add Stage    xpath: //*[text() = '@{BASE_BRANCH_NODES}[0]']    test    @{STAGE_TYPE}[3]  @{PUBLISH_EVENT_TYPE}[0]
    Then Element Should Be Visible  xpath: //*[text() = '@{STAGE_TYPE}[3]']


Test Edit Stage
    [Documentation]  Should edit Stage values
    [Tags]  Stage  Edit  succeed
    Expand Node   @{BASE_BRANCH_CAT}[0]
    Expand Node    @{BASE_BRANCH_NODES}[0]
    Edit Stage    xpath: //*[text()="@{BASE_BRANCH_NODES}[1]"]   event    ALL
    element should be visible  xpath: //*[text()="@{BASE_BRANCH_NODES}[1]"]
    Edit Stage    xpath: //*[text()="@{BASE_BRANCH_NODES}[1]"]   Auto    NONE


Test Remove Stage
    Given Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    When Remove Stage    xpath: //*[text()='@{STAGE_TYPE}[3]']
    Then Element Should Not Be Visible  xpath: //*[text() = '@{STAGE_TYPE}[3]']


Test Add Activity
    Given Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    When Add Activity  xpath: //*[text() = '@{BASE_BRANCH_NODES}[1]']  Auto Activity  @{PUBLISH_EVENT_TYPE}[0]
    Then Element Should Be Visible  xpath: //*[text() = 'Auto Activity']


Test Edit Activity
    [Documentation]  Should edit Stage values
    [Tags]  Stage  Edit  succeed
    Expand Node   @{BASE_BRANCH_CAT}[0]
    Expand Node    @{BASE_BRANCH_NODES}[0]
    Edit Activity   xpath: //*[text()="Auto Activity"]   event    ALL
    Edit Activity   xpath: //*[text()="event"]   Auto Activity    ALL


Test Remove Activity
    Given Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    When Remove Activity  xpath: //*[text()='Auto Activity']
    Then Element Should not Be Visible  xpath: //*[text() = 'Auto Activity']


Test Add Form
    Given Expand Node   @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    When Add Form    xpath: //*[text() = 'ActivityX']


Test Remove Form
    Expand Node   @{BASE_BRANCH_CAT}[0]
    Expand Node    @{BASE_BRANCH_NODES}[0]
    ${form_name}=   Get Text    xpath: //*[contains(text(), "Questionnaire :")][last()]
    Remove Form    ${form_name}


Test Add Page
    Given Expand Node    @{BASE_BRANCH_CAT}[0]
    And Expand Node    @{BASE_BRANCH_NODES}[0]
    ${form_name}=   Get Text    xpath: //*[contains(text(), "Questionnaire :")][last()]
    When Add Page In Unity    xpath: //*[text() = '${form_name}']    Test_New_Page
    Then Element Should Be Visible    xpath: //*[contains(text(),' : Test_New_Page')]


Test Edit Page
    [Documentation]  Should edit Stage values
    [Tags]  Stage  Edit  succeed
    Expand Node   @{BASE_BRANCH_CAT}[0]
    Expand Node    @{BASE_BRANCH_NODES}[0]
    Edit Page  xpath: //*[text()="@{BASE_BRANCH_NODES}"]   event


Open Clarity From Unity
    [Tags]  Clarity
    Expand Node   @{BASE_BRANCH_CAT}[0]
    Expand Node    @{BASE_BRANCH_NODES}[0]
    ${form_name}=  Get Text    xpath: //*[contains(text(), "Questionnaire :")][last()]
    Open Form In Clarity  xpath: //*[text()="${form_name}"]


*** Keywords ***

Expand Node      # Click on an element by its text
    [Arguments]    ${location}   ${expected}
    click element   xpath: //*[text()= '${text}']
    Wait Until Element Is Visible    ${expected}
