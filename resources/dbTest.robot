*** Settings ***
library  DB  ${hn}   ${db}   ${ur}   ${pw}

*** Test Cases ***
Conect to db
    Get Test
    ${result}=  Get result
    Log To Console   ${result}
