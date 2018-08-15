*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description

Set Selenium Speed  0.5

*** Test Cases ***
Test title
    [Tags]    DEBUG
    Open Browser  ${page}  GoogleChrome
    Click Element   xpath: //*[contains(@id, 'qId_/_')]
