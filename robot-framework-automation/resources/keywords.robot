*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Keywords ***
Login
    Wait Until Element Is Visible    id=organization    20s
    Input Text    id=organization    lakhok
    Input Text    id=username        leo
    Input Text    id=password        username
    Click Element    xpath=//button[@type='submit']
    Wait Until Location Does Not Contain    login    20s
    Wait Until Element Is Visible    xpath=//nav | //aside | //header    20s

Go To Documents
    Wait Until Element Is Visible    xpath=//a[contains(@href,'documents')]    20s
    Click Element                    xpath=//a[contains(@href,'documents')]
    Wait Until Location Contains     documents    20s
    Sleep    3s

Open Add Modal
    Set Window Size    1920    1080
    Sleep    2s
    Wait Until Page Contains Element
    ...    xpath=//button[.//span[contains(text(),'เพิ่มเอกสาร')]]
    ...    30s
    Execute Javascript
    ...    document.querySelector("button.from-emerald-600").click()
    Wait Until Element Is Visible
    ...    xpath=//input[@placeholder='กรอกชื่อเอกสารสำคัญ']
    ...    20s

Fill And Submit Document
    Wait Until Element Is Visible
    ...    xpath=//input[@placeholder='กรอกชื่อเอกสารสำคัญ']    20s
    Input Text
    ...    xpath=//input[@placeholder='กรอกชื่อเอกสารสำคัญ']    test doc stable
    Choose File    xpath=//input[@type='file']    ${FILE}
    Sleep    5s
    Execute Javascript
    ...    document.querySelectorAll("button").forEach(b => { if(b.innerText.includes('บันทึกข้อมูล')) b.click() })
    Wait Until Element Is Not Visible
    ...    xpath=//input[@placeholder='กรอกชื่อเอกสารสำคัญ']
    ...    60s

Verify Result
    Wait Until Page Contains    test doc stable    30s
    Page Should Contain    test doc stable