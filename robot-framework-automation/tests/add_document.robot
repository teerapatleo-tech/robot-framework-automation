*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Resource    /Users/mac/robot-framework-automation/resources/keywords.robot
Resource    /Users/mac/robot-framework-automation/resources/variables.robot

*** Test Cases ***
Add Document Flow Stable
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    2s
    Login
    Go To Documents
    Open Add Modal
    Fill And Submit Document
    Verify Result
    Close Browser