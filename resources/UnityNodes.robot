*** Settings ***
Library  SeleniumLibrary
Resource  ACT_Variables.robot

Force Tags  Unity

Suite Setup  Run Keywords
...          Open Browser  ${page}  ${browser}
...          AND           maximize browser window

Suite Teardown  Close Browser
Test Setup      Sleep         2
Test Teardown   Reload Page
