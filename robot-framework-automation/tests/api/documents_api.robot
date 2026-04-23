*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     OperatingSystem
Suite Setup    Get And Set Token

*** Variables ***
${AUTH_URL}     https://limbic-auth-uat.qualitybrain.tech
${API_URL}      https://limbic-doc-uat.qualitybrain.tech
${TOKEN}        ${EMPTY}
${CREATED_ID}   ${EMPTY}
${VALID_PDF}    /Users/mac/robot-framework-automation/test-data/test.pdf

*** Test Cases ***
TC-API-DOC-01 GET รายการเอกสารทั้งหมด
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    Create Session    api    ${API_URL}    headers=${headers}    verify=False
    ${response}=    GET On Session    api    /drawings/
    Status Should Be    200    ${response}
    ${body}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${body}
    Dictionary Should Contain Key    ${body}[0]    _id
    Dictionary Should Contain Key    ${body}[0]    name
    Dictionary Should Contain Key    ${body}[0]    pdf_url
    Dictionary Should Contain Key    ${body}[0]    organize_id

TC-API-DOC-02 GET เช็ค organize_id ถูกต้อง
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    Create Session    api2    ${API_URL}    headers=${headers}    verify=False
    ${response}=    GET On Session    api2    /drawings/
    Status Should Be    200    ${response}
    FOR    ${doc}    IN    @{response.json()}
        Should Be Equal As Numbers    ${doc}[organize_id]    4
    END

TC-API-DOC-03 POST เพิ่มเอกสารใหม่
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    Create Session    api3    ${API_URL}    headers=${headers}    verify=False
    ${file}=    Get Binary File    ${VALID_PDF}
    ${files}=    Create Dictionary
    ...    file=("test_api.pdf", ${file}, "application/pdf")
    ${data}=    Create Dictionary
    ...    name=test doc api
    ...    updated_by=leo
    ${response}=    POST On Session    api3    /drawings/
    ...    files=${files}
    ...    data=${data}
    Status Should Be    201    ${response}
    Should Be Equal    ${response.json()}[message]    Drawing created successfully
    Should Not Be Empty    ${response.json()}[id]
    Set Suite Variable    ${CREATED_ID}    ${response.json()}[id]

TC-API-DOC-04 DELETE ลบเอกสารที่เพิ่งสร้าง
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    Create Session    api4    ${API_URL}    headers=${headers}    verify=False
    ${response}=    DELETE On Session    api4    /drawings/${CREATED_ID}
    Status Should Be    200    ${response}

*** Keywords ***
Get And Set Token
    Create Session    auth    ${AUTH_URL}    verify=False
    ${body}=    Create Dictionary
    ...    org_name=lakhok
    ...    username=leo
    ...    password=username
    ${response}=    POST On Session    auth    /api/auth/login    json=${body}
    ${token}=    Set Variable    ${response.json()}[data][access_token]
    Set Suite Variable    ${TOKEN}    ${token}