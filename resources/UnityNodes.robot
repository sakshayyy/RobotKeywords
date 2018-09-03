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

Test Add SDT Root  #Add SDT via root node
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  Unity  SDT  Add  succeed
    Given Title Should Be   Unity
    When Element Should Be Visible    ${rootnode}
    And Add SDT  ${rootnode}  AUTO_GEN_SDT_ROOT  From Root  @{testbranch}
    And Sleep    1
    And Expand Node    @{testbranch}[0]
    Then Element Should Be Visible   xpath: //*[text() = 'From Root']


Test Remove SDT From Root  #Remove
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  Unity  SDT  Remove  succeed
    Given Title Should Be   Unity
    When Expand Node  @{testbranch}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Root']
    And Remove SDT   xpath: //*[text() = 'From Root']
    Then element should not be visible   xpath: //*[text() = 'From Root']


Test Add SDT Cat 3  #Add SDT via specified cat 3 node
    #TODO - make less static
    [Documentation]  Should create a new SDT with the context menu from a catagoty 3 node
    [Tags]  Unity  SDT  Add  succeed
    Given Title Should Be   Unity
    When Expand Node  @{staticbranch}[0]  #Name of parent node
    And Add SDT       xpath: //*[text() = 'Alter']  AUTO_GEN_SDT_CAT3  From Cat 3  @{testbranch}
    And Expand Node    @{testbranch}[0]
    And Expand Node  @{staticbranch}[0]
    Then Element Should Be Visible   xpath: //*[text() = 'From Cat 3']


Test Edit SDT
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  Unity  SDT  Edit  succeed
    Given Title Should Be   Unity
    When Expand Node  @{staticbranch}[0]
    And Element Should Be Visible  xpath: //*[text() = '@{edit_sdt}[0]']
    When Edit SDT   xpath: //*[text() = '@{edit_sdt}[0]']  @{staticbranch}  TEST_EDIT  Edit Test
    Then element should be visible  xpath: //*[text() = 'Edit Test']
    And Edit SDT   xpath: //*[text() = 'Edit Test']  @{staticbranch}  EDIT  @{edit_sdt}[0]


Test Remove SDT  #
    #TODO - make less static
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  Unity  SDT  Remove  succeed
    Given Title Should Be   Unity
    When Expand Node  @{testbranch}[0]
    And Element Should Be Visible    xpath: //*[text() = 'From Cat 3']
    And Remove SDT   xpath: //*[text() = 'From Cat 3']
    Then element should not be visible   xpath: //*[text() = 'From Cat 3']


Test Add Stage  #Add New Stage
    [Documentation]  Add Stage to Existing branch
    [Tags]  Unity  Stage  Add  succeed
    Given Title Should Be   Unity
    When Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    And Add Stage    xpath: //*[text() = '@{edit_sdt}[0]']    TEST    @{stage_type}[3]  @{event_publish}[0]
    Then Element Should Be Visible  xpath: //*[text() = '@{stage_type}[3]']


Test Edit Stage
    [Documentation]  Should edit Stage values
    [Tags]  Unity  Stage  Edit  succeed
    Given Title Should Be   Unity
    When Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    And Edit Stage    xpath: //*[text()="@{edit_sdt}[1]"]   EVENT    ALL
    Then element should be visible  xpath: //*[text()="@{edit_sdt}[1]"]


Test Remove Stage
    [Tags]  Unity
    Given Title Should Be   Unity
    When Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    And Remove Stage    xpath: //*[text()='@{stage_type}[3]']
    Then Element Should Not Be Visible  xpath: //*[text() = '@{stage_type}[3]']


Test Add Activity
    [Tags]  Unity
    Given Title Should Be   Unity
    When Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    And Add Activity  xpath: //*[text() = '@{edit_sdt}[1]']  Auto Activity  @{event_publish}[0]
    Then Element Should Be Visible  xpath: //*[text() = 'Auto Activity']


Test Edit Activity
    [Documentation]  Should edit Stage values
    [Tags]  Unity  Stage  Edit  succeed
    Given Title Should Be   Unity
    When Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    And Edit Activity   xpath: //*[text()="Auto Activity"]   Auto Activity Edit    ALL
    Then Element Should Be Visible  xpath: //*[text() = 'Auto Activity Edit']


Test Remove Activity
    [Tags]  Unity
    Given Title Should Be   Unity
    When Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    And Remove Activity  xpath: //*[text()='Auto Activity Edit']
    Then Element Should not Be Visible  xpath: //*[text() = 'Auto Activity Edit']


Test Add Form
    [Tags]  Unity
    Given Title Should Be   Unity
    When Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    And Add Form    xpath: //*[text() = 'ActivityX']


Test Remove Form
    [Tags]  Unity
    Given Title Should Be   Unity
    When Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    ${form_name}=   Get Text    xpath: (//*[contains(text(), "Questionnaire :")[1]
    And Remove Form    xpath: //*[text()= "${form_name}"]
    Then Element Should not Be Visible    xpath: //*[text()= "${form_name}"]


Test Add Page
    [Tags]  Unity
    Given Title Should Be   Unity
    When Expand Node    @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    ${form_name}=   Get Text    xpath: //*[contains(text(), "Questionnaire :")][last()]
    And Add Page In Unity    xpath: //*[text() = '${form_name}']    Test_New_Page
    Then Element Should Be Visible    xpath: //*[contains(text(),' : Test_New_Page')]


Test Edit Page
    [Documentation]  Should edit Stage values
    [Tags]  Unity  Stage  Edit  succeed
    Given Title Should Be   Unity
    When Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    And Edit Page  xpath: //*[contains(text(),": Test_New_Page")]   Test_New_Page_Edit
    Then Element Should Be Visible  xpath: //*[contains(text(),": Test_New_Page_Edit"]


Open Clarity From Unity
    [Tags]  Unity  Clarity
    Given Title Should Be   Unity
    When Expand Node   @{staticbranch}[0]
    And Expand Node    @{edit_sdt}[0]
    ${form_name}=  Get Text    xpath: //*[contains(text(), "Questionnaire :")][last()]
    And Open Form In Clarity  xpath: //*[text()="${form_name}"]
    Then Clarity Form Should Be Open


*** Keywords ***

Expand Node      # Click on an element by its text
    [Arguments]    ${location}   ${expected}
    click element   xpath: //*[text()= '${text}']
    Wait Until Element Is Visible    ${expected}
