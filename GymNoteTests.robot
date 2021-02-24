*** Settings ***
Library    SeleniumLibrary
Resource    GymNoteResources.robot
*** Test Cases ***
Check gymnote availability
    [Tags]    critical
    [Documentation]    This test verifies that main page is available and login form is working.
    [Setup]    Gymnote tests setup
    Check if training page is available
    [Teardown]    Close browser

Check if side menu and it subpages are working correctly
    [Documentation]    This test verifies that elements of side menu are redirecting to subpages correctly.
    [Setup]    Gymnote tests setup 
    Choose side menu element    Ustawienia
    Check if settings page is available
    Choose side menu element    Kalkulator Deficytu
    Check if deficit calculator page is available
    Choose side menu element    Cele
    Check if goals page is available
    Choose side menu element    Trening
    Check if training page is available
    Choose side menu element    Statystyki
    Check if statistics page is available
    Choose side menu element    Strona główna
    [Teardown]    Close browser

Check adding and deleting measurements
    [Documentation]    This test verifies that adding new measurements works.
    [Setup]    Gymnote tests setup
    Choose side menu element  Statystyki
    Fill and submit measurements form    01/01/2077    100    95    90    85    80    75    70    65    60
    Verify added measurements    2077-01-01    100    95    90    85    80    75    70    65    60
    Delete measurements    2077-01-01
    Reload page
    Choose side menu element  Statystyki
    Verify that measurements has been deleted    2077-01-01
    [Teardown]    Close browser

Check latest updated statistics on user page
    [Documentation]    This test verifies that statistics on user page are updated correctly.
    [Setup]    Gymnote tests setup
    Choose side menu element  Statystyki
    Fill and submit measurements form    01/01/2077    100    95    90    85    80    75    70    65    60
    Verify added measurements    2077-01-01    100    95    90    85    80    75    70    65    60
    Choose side menu element    Strona główna
    Verify measurements update on user page    01-01-2077    100    95    90    85    80    75    70    65    60
    Choose side menu element  Statystyki
    Check deleting measurements    2077-01-01
    [Teardown]    Close browser

Check adding, setting active, executing and deleting training plan
    [Tags]    test
    [Documentation]    This test verifies that adding new training plan, setting it active, executing new training and deleting training plan works.
    [Setup]    Gymnote tests setup
    Choose side menu element    Trening
    Check if training page is available
    Add new training plan    testTrainingPlanName    testTrainingExercise    testTrainingExercise2
    FOR    ${i}    IN RANGE    30
        Reload Page
        Choose side menu element    Trening
        Check if training page is available
        Verify added training plan    testTrainingPlanName
        Set training plan active    testTrainingPlanName
        Choose side menu element    Strona główna
        ${status}=    Run keyword and return status    Verify active training plan on user page    testTrainingPlanName
        Exit For Loop If    '${status}' == 'True'
    END
    Choose side menu element    Trening
    Check if training page is available
    Add executed training    50    5
    FOR    ${i}    IN RANGE    30
        Choose side menu element    Trening
        Check if training page is available
        Delete training plan    testTrainingPlanName
        Reload Page
        Choose side menu element    Trening
        Check if training page is available
        ${status}=    Run keyword and return status    Verify that training plan has been deleted  testTrainingPlanName
        Exit For Loop If    '${status}' == 'True'
    END
    [Teardown]    Close browser

Check adding and deleting new goal
    [Tags]    test
    [Documentation]    This test tries to add a new goal and verify that it is being displayed correctly in goals subpage then tries to delete it and verifies it.
    [Setup]    Gymnote tests setup
    Choose side menu element    Cele
    Check if goals page is available
    Add new goal    Testing goal    Testing goal description    130    Waga    Mniejsze/Równe
    Choose side menu element    Cele
    Check if goals page is available
    Verify achieved goal    Testing goal description
    Verify added goal    Testing goal    Testing goal description
    Delete goal  Testing goal description
    Choose side menu element    Cele
    Check if goals page is available
    Verify deleted goal    Testing goal    Testing goal description
    [Teardown]    Close browser

Check achieving goal
    [Tags]    test
    [Documentation]    This test verifies that achieving goals works as intended.
    [Setup]    Gymnote tests setup
    Choose side menu element  Statystyki
    Fill and submit measurements form    01/01/2077    100    95    90    85    80    75    70    65    60
    Verify added measurements    2077-01-01    100    95    90    85    80    75    70    65    60
    Choose side menu element    Cele
    Check if goals page is available
    Add new goal    Testing goal    Testing goal description    95    Waga    Mniejsze/Równe
    Choose side menu element    Cele
    Check if goals page is available
    Verify added goal    Testing goal    Testing goal description
    Verify not achieved goal  Testing goal description
    Choose side menu element  Statystyki
    Fill and submit measurements form    02/01/2077    90    95    90    85    80    75    70    65    60
    Verify added measurements    2077-01-02    90    95    90    85    80    75    70    65    60
    Choose side menu element    Cele
    Check if goals page is available
    Verify achieved goal  Testing goal description
    Delete goal  Testing goal description
    Choose side menu element    Cele
    Check if goals page is available
    Verify deleted goal    Testing goal    Testing goal description
    Choose side menu element  Statystyki
    Check deleting measurements    2077-01-01
    Check deleting measurements    2077-01-02
    [Teardown]    Close browser