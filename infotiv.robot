*** Settings ***
Documentation           The information about the testsuite
Resource                ../Resources/keywords.robot
Library                 SeleniumLibrary

Test Setup             Begin Web Test
Test Teardown          End Web Test


*** Variables ***
${BROWSER}=  chrome
${URL}=  http://rental17.infotiv.net
${VALID EMAIL}=  iovu.mihaela@hotmail.com
${VALID PASSWORD}=  infotivselenium


*** Test Cases ***

Successful login
    [Documentation]                         Successful login
    [Tags]                                  login
    Given Go To Start Page
    When Login                              ${VALID EMAIL}  ${VALID PASSWORD}
    Then Wait Until Page Contains           You are signed in as Mihaela


Invalid login with wrong password
    [Documentation]                         Invalid login and get message when using wrong password
    [Tags]                                  login
    Given Go To Start Page
    When Login                              ${VALID EMAIL}  invalid
    Then Wait Until Page Contains           Wrong e-mail or password


Invalid login with empty password
    [Documentation]                         Invalid login, empty password and get alert
    [Tags]                                  login
    Given Go To Start Page
    When Login                              ${VALID EMAIL}  ${EMPTY}
    Then Wait Until Element Is Visible      css:#password:invalid


Car choice
    [Documentation]                         Choose car Audi, 2 passengers
    [Tags]                                  choose_car
    Given Go To Start Page
    and Select valid dates
    When Choose a car
    Then Verify car model
    and Verify number of passengers


Nonexisting car choice
    [Documentation]                         Choose a car that doesn't exist
    [Tags]                                  choose_car
    Given Go To Start Page
    and Select valid dates
    When Choose a nonexisting car
    Then Wait Until Page Contains           No cars with selected filters. Please edit filter selection.


Invalid start date selection
    [Documentation]                         Select invalid start date
    [Tags]                                  date_selection
    Given Go To Start Page
    When Select invalid start date
    Then Wait Until Element Is visible      css:#start:invalid


Invalid end date selection
    [Documentation]                         Select invalid end date
    [Tags]                                  date_selection
    Given Go To Start Page
    When Select invalid end date
    Then Wait Until Element Is visible       css:#end:invalid


Valid date selection
    [Documentation]                         Select valid date
    [Tags]                                  date_selection
    Given Go To Start Page
    When Select valid dates
    Then Wait Until Page Contains           What would you like to drive?


Car booking
    [Documentation]                         book a car and unbook it
    [Tags]                                  book_car
    Book car
    Go to My Page
    Wait Until Page Contains Element        xpath://*[@id="middlepane"]/table/tbody/tr[2]
    Unbook car
    Wait Until Page Contains                You have no bookings


VG_test
    [Documentation]                         Book car and go back to start page
    [Tags]                                  book_car
    Given Book car
    When Click Home button
    Then Wait Until Page Contains           When do you want to make your trip?

