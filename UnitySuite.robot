*** Settings ***
Library  SeleniumLibrary
Resource  resources/generickeywords.robot
Resource  resources/unitykeywords.robot
Resource  resources/variables.robot

Suite Setup     Run Keywords  Open Browser  ${page}  ${browser}
...             AND           maximize browser window
...             AND           Set Selenium Speed  0.5

Suite Teardown  Close Browser

Test Teardown   Refresh Unity

*** Test Cases ***
Add SDT Root
    Add SDT      ${rootnode}  AUTO_GEN_SDT_${counter}  Auto Gen SDT
    Increment Counter


Add SDT Cat 3
    Click Text    Cat 1 - Auto
    Add SDT       Cat 3 - Auto  AUTO_GEN_SDT_${counter}  Auto Gen SDT From Cat 3
    Increment Counter


Remove SDT Cat 3
    Click Text    AutoTest Cat 1
    element should be visible  xpath: //*[text()= 'Auto Gen SDT From Cat 3']
    Remove SDT  Auto Gen SDT From Cat 3
    element should not be visible  xpath: //*[text() = 'Auto Gen SDT From Cat 3']
