*** Settings ***
Library  SeleniumLibrary
Resource  resources/generickeywords.robot
Resource  resources/unitykeywords.robot
Resource  resources/variables.robot

Force Tags  Unity

Suite Setup     Run Keywords  Open Browser  ${page}  ${browser}
...             AND           maximize browser window
...             AND           Set Selenium Speed  0.5

Suite Teardown  Close Browser

Test Teardown   Refresh Unity

*** Test Cases ***
Add SDT Root
    [Documentation]  Should create a new SDT with the context menu from Root
    [Tags]  SDT  Add  succed
    Add SDT      ${rootnode}  AUTO_GEN_SDT_${counter}  Auto Gen SDT
    Increment Counter


Add SDT Cat 3
    [Documentation]  Should create a new SDT with the context menu from a catagoty 3 node
    [Tags]  SDT  Add  succed
    Click Text    Cat 1 - Auto
    Add SDT       Cat 3 - Auto  AUTO_GEN_SDT_${counter}  Auto Gen SDT From Cat 3
    Increment Counter


Remove SDT Cat 3
    [Documentation]  Should remove the SDT from "Add SDT Cat 3"
    [Tags]  SDT  Remove  succed
    Click Text    AutoTest Cat 1
    element should be visible  Text XPath  Auto Gen SDT From Cat 3
    Remove SDT  Auto Gen SDT From Cat 3
    element should not be visible  Text XPath  Auto Gen SDT From Cat 3








