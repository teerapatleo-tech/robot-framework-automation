*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     OperatingSystem
Suite Setup    Get And Set Token

*** Variables ***
${AUTH_URL}     %{AUTH_URL}
${API_URL}      %{API_URL}
${ORG_NAME}     %{ORG_NAME}
${USERNAME}     %{LOGIN_USERNAME}
${PASSWORD}     %{LOGIN_PASSWORD}
${TOKEN}        ${EMPTY}
${CREATED_ID}   ${EMPTY}
${VALID_PDF}    /Users/mac/robot-framework-automation/test-data/test.pdf

*** Keywords ***
Get And Set Token
    Create Session    auth    ${AUTH_URL}    verify=False
    ${body}=    Create Dictionary
    ...    org_name=${ORG_NAME}
    ...    username=${USERNAME}
    ...    password=${PASSWORD}
    ${response}=    POST On Session    auth    /api/auth/login    json=${body}
    ${token}=    Set Variable    ${response.json()}[data][access_token]
    Set Suite Variable    ${TOKEN}    ${token}