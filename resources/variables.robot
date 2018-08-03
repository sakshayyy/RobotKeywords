*** Variables ***
${counter}      ${0}
${browser}      GoogleChrome
${page}         http://pcm-dev1-1163553704.eu-west-2.elb.amazonaws.com/unity/#
${rootnode}     xpath: //*[contains(@id, 'qId_/_')]

@{branch}       Cat 1   Cat 2   Cat 3

*** Test Cases ***
test
    log  ${counter}
    increment counter
    log  ${counter}


*** Keywords ***
Increment Counter
    ${counter}=  evaluate  ${counter} +  ${1}
