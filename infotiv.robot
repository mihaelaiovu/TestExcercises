*** Settings ***
Documentation           The information about the testsuite
Library                 SeleniumLibrary

Test Setup             Begin Web Test
Test Teardown          End Web Test


*** Variables ***
${BROWSER}=  chrome
${URL}=  http://rental17.infotiv.net
${VALID EMAIL}=  iovu.mihaela@hotmail.com
${VALID PASSWORD}=  infotivselenium

*** Keywords ***

Begin Web Test
        Open Browser                    about:blank  ${BROWSER}
        Maximize Browser Window

Go To Start Page
        Load Page
        Verify Page Loaded

Load Page
        Go To                           ${URL}

Verify Page Loaded
        ${link_text} =                  Get Text  xpath://*[@id="title"]
        Should Be Equal                 ${link_text}  Infotiv Car Rental

Go to My Page
        Click button                        xpath://*[@id="mypage"]

Login
        [Arguments]                         ${email}        ${password}
        Input text                          id:email   ${email}
        Input text                          id:password    ${password}
        Click button                        xpath://*[@id="login"]

Choose a car
        List car models
        Select car model
        List number of passengers
        Select number of passengers

List car models
        Click button                        xpath://*[@id="ms-list-1"]/button

Select car model
        Select checkbox                     xpath://*[@id="ms-opt-1"]

List number of passengers
        Click button                        xpath://*[@id="ms-list-2"]/button

Select number of passengers
        Select checkbox                     xpath://*[@id="ms-opt-5"]

Verify car model
        ${actual_model}=                    Get Text  xpath://*[@id="ms-list-1"]/button/span
        Should be Equal                     ${actual_model}    Audi

Verify number of passengers
        ${actual_persons}=                  Get Text  xpath://*[@id="ms-list-2"]/button/span
        Should Be Equal                     ${actual_persons}     2

Choose a nonexisting car
        List car models
        Select checkbox                      xpath://*[@id="ms-opt-4"]
        List number of passengers
        Select number of passengers

Select invalid start date
        ${start_date}=                      Get Time        day month  now-1 day
        Input text                          id:start  ${start_date}
        Click button                        id:continue

Select invalid end date
        ${end_date}=                        Get Time        day month       now+32 day
        Input text                          id:end    ${end_date}
        Click button                        id:continue

Select valid dates
        ${start_date}=                      Get Time        day month       now+10 day
        ${end_date}=                        Get Time        day month       now+20 day
        Input text                          id:start  ${start_date}
        Input text                          id:end    ${end_date}
        Click button                        id:continue


Submit book car
        Click button                        id:carSelect1

Write card details
        Card number
        Card name
        Card month
        Card year
        Card cvc
        Submit card

Card number
        Input text                          id:cardNum      1234567891234567

Card name
        Input text                          id:fullName     M I

Card month
        Select From List By Index            xpath://*[@id="confirmSelection"]/form/select[1]   10

Card year
        Select From List By Index            xpath://*[@id="confirmSelection"]/form/select[2]  4

Card cvc
        Input text                          id:cvc          123

Submit card
        Click button                        id:confirm

Book car
        Unbook all my booked cars
        Select valid dates
        Choose a car
        Sleep     1s
        Click element                      id:questionText
        Submit book car
        Write card details

Click Home button
        Click button                        id:home

Unbook car
        Click button                        xpath://*[@id="unBook1"]
        Handle Alert
        Go to My Page


Unbook all my booked cars
        Go To Start Page
        Login                               ${VALID EMAIL}  ${VALID PASSWORD}
        Go to My Page
        Unbook all cars if they exist
        Go to Start Page


Unbook all cars if they exist
        ${no_of_booked_cars}=     Get Element Count     xpath://*[@id="middlepane"]/table/tbody/tr
        LOG TO CONSOLE   no_of_booked_cars ${no_of_booked_cars}
        :FOR  ${iteration}  IN RANGE      1        (${no_of_booked_cars})
        \     Unbook car


End Web Test
        Close Browser

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
    Sleep                                   1s
    Wait Until Page Contains Element        xpath://*[@id="middlepane"]/table/tbody/tr[2]
    Unbook car
    Wait Until Page Contains                You have no bookings


VG_test
    [Documentation]                         Book car and go back to start page
    [Tags]                                  book_car
    Given Book car
    When Click Home button
    Then Wait Until Page Contains           When do you want to make your trip?

