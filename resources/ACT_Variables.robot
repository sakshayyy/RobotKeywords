*** Settings ***
Documentation   Contains data for the ACT test suite. Change data here to affect all tests.

*** Variables ***
@{STAGE_TYPE}             RESOLVE_IDENTITY    MANAGE_PARTY    CHECK_AND_VALIDATE    DECISION_MAKING   FULFILLMENT   FULFILLMENT_EXECUTION   RIS
@{PUBLISH_EVENT_TYPE}     SELF   ALL   NONE

@{BASE_BRANCH_CAT}        D o  Not  Alter  This  Branch
@{BASE_BRANCH_NODES}      EDIT  RIS  ActivityX  Questionnaire : 920501285  New page
@{NEW_BRANCH_CAT}         Auto 1    Auto 2    Auto 3    Auto 4    Auto 5
@{NEW_BRANCH_NODES}

${BROWSER}                GoogleChrome
${ROOT}                   xpath: //*[contains(@id, 'qId_/_')]
