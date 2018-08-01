*** Settings ***
Library  SeleniumLibrary
Library  ./resources/unitykeywords


Suite Setup             Suite Inital Conditions
Suite Teardown          close browser

#Test Teardown           reload page


*** Variables ***
${browser}   GoogleChrome
${page}     http://pcm-dev1-1163553704.eu-west-2.elb.amazonaws.com/unity/#


*** Test Cases ***
Add SDT Root
    open context menu   xpath: //*[text()= 'Root']
    click element  xpath: //*[text() = 'Add New Service Delivery Type']
    input text  id: Category1   AutoTest Cat 1
    input text  id: Category2   Cat 2
    input text  id: Category3   Cat 3
    input text  id: Code        AUTO_Root
    input text  id: Text        Auto Gen SDT From Root
    click button  class: btn-save
    capture page screenshot



Add SDT Cat 3
    click element  xpath: //*[text()= 'Cat 1 - Auto']
    open context menu   xpath: //*[text()= 'Cat 3 - Auto']
    click element  xpath: //*[text() = 'Add New Service Delivery Type']
    input text  id: Category1   AutoTest Cat 1
    input text  id: Category2   Cat 2
    input text  id: Category3   Cat 3
    input text  id: Code        AUTO_CAT_3
    input text  id: Text        Auto Gen SDT From Cat 3
    click button  class: btn-save

Remove SDT
    reload page
    sleep   2
    click element  xpath: //*[text() = 'AutoTest Cat 1']
    element should be visible  xpath: //*[text()= 'Auto Gen SDT From Cat 3']
    Remove SDT  Auto Gen SDT From Cat 3
    element should not be visible  xpath: //*[text() = 'Auto Gen SDT From Cat 3']

*** Keywords ***
suite Inital Conditions
     Open Browser  ${page}  ${browser}
     maximize browser window
     Set Selenium Speed  0.5