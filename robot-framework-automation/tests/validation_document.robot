*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Resource    /Users/mac/robot-framework-automation/resources/keywords.robot
Resource    /Users/mac/robot-framework-automation/resources/variables.robot

*** Test Cases ***
TC-DOC-06-01 Validation ไม่กรอกชื่อเอกสาร
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login
    Go To Documents
    Open Add Modal
    Choose File    xpath=//input[@type='file']    ${VALID_PDF}
    Submit Form
    Page Should Contain    กรุณากรอกชื่อเอกสาร
    [Teardown]    Close Browser

TC-DOC-06-02 Validation ไม่แนบไฟล์ PDF
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login
    Go To Documents
    Open Add Modal
    Input Text    xpath=//input[@placeholder='กรอกชื่อเอกสารสำคัญ']    test validation
    Submit Form
    Page Should Contain    กรุณาเลือกไฟล์ PDF
    [Teardown]    Close Browser

TC-DOC-06-03 Validation ไฟล์ผิดประเภท
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login
    Go To Documents
    Open Add Modal
    Input Text    xpath=//input[@placeholder='กรอกชื่อเอกสารสำคัญ']    test validation
    Choose File    xpath=//input[@type='file']    ${INVALID_FILE}
    Submit Form
    Page Should Contain    โปรดเลือกไฟล์ PDF เท่านั้น
    [Teardown]    Close Browser

TC-DOC-06-04 Validation ไฟล์เกิน 25MB
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Login
    Go To Documents
    Open Add Modal
    Input Text    xpath=//input[@placeholder='กรอกชื่อเอกสารสำคัญ']    test validation
    Choose File    xpath=//input[@type='file']    ${LARGE_PDF}
    Sleep    2s
    Capture Page Screenshot    filename=large_file_validation.png
    Submit Form
    Sleep    2s
    Capture Page Screenshot    filename=large_file_after_submit.png
    Page Should Contain    ไฟล์มีขนาดใหญ่เกินไป ขนาดสูงสุดคือ 25MB
    [Teardown]    Close Browser

*** Keywords ***
Submit Form
    Execute Javascript
    ...    document.querySelectorAll("button").forEach(b => { if(b.innerText.includes('บันทึกข้อมูล')) b.click() })
    Sleep    2s