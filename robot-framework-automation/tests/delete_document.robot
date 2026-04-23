*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Resource    /Users/mac/robot-framework-automation/resources/keywords.robot
Resource    /Users/mac/robot-framework-automation/resources/variables.robot

*** Test Cases ***
TC-DOC-09-02-01 ลบเอกสาร และยืนยันการลบ
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login
    Go To Documents
    Click Delete Button
    Confirm Delete
    Page Should Contain    ลบเอกสารเรียบร้อยแล้ว
    [Teardown]    Close Browser

TC-DOC-09-02-02 ลบเอกสาร และยกเลิกการลบ
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login
    Go To Documents
    ${doc_count_before}=    Get Element Count    xpath=//table//tbody//tr
    Click Delete Button
    Cancel Delete
    ${doc_count_after}=    Get Element Count    xpath=//table//tbody//tr
    Should Be Equal    ${doc_count_before}    ${doc_count_after}
    [Teardown]    Close Browser

*** Keywords ***
Click Delete Button
    # คลิกปุ่มลบของแถวแรก
    Wait Until Element Is Visible
    ...    xpath=//table//tbody//tr[1]//button[contains(@class,'text-red')]
    ...    20s
    Click Element
    ...    xpath=//table//tbody//tr[1]//button[contains(@class,'text-red')]
    # รอ pop-up ขึ้น
    Wait Until Element Is Visible
    ...    xpath=//*[contains(text(),'ยืนยันการลบ')]
    ...    10s

Confirm Delete
    Click Element    xpath=//button[.//span[contains(text(),'ลบ')]]
    Sleep    2s

Cancel Delete
    Click Element    xpath=//button[contains(text(),'ยกเลิก')]
    Sleep    1s
    # ตรวจว่า pop-up ปิดแล้ว
    Wait Until Element Is Not Visible
    ...    xpath=//*[contains(text(),'ยืนยันการลบ')]
    ...    10s