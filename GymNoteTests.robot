*** Settings ***
Library    SeleniumLibrary
Resource    GymNoteResources.robot
*** Test Cases ***
Check gymnote availability
    [Tags]    critical
    [Documentation]    This test verifies that main page is available and login form is working.
    Open browser and open gymnote app
    Login with given account
    Check if training page is available
    Close browser

#Check register form
#    [Documentation]    This test verifies that register form requires all fields to be filled.
#    Open browser and open gymnote app
#    Go to register form
#    Fill and submit register form    matgra0004    passw123    matgra0004@wp.pl
#    Close browser    

Check if side menu and it subpages are working correctly
    [Documentation]    This test verifies that elements of side menu are redirecting to subpages correctly.
    Open browser and open gymnote app
    Login with given account    
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
    Close browser

Check adding measurements
    [Documentation]    This test verifies that adding new measurements works.
    Open browser and open gymnote app
    Login with given account
    Choose side menu element  Statystyki
    Fill and submit measurements form    01/01/2077    100    95    90    85    80    75    70    65    60
    Verify added measurements    2077-01-01    100    95    90    85    80    75    70    65    60
    Check deleting measurements    2077-01-01
    Close browser

Check latest updated statistics on user page
    [Documentation]    This test verifies that statistics on user page are updated correctly.
    Open browser and open gymnote app
    Login with given account
    Choose side menu element  Statystyki
    Fill and submit measurements form    01/01/2077    100    95    90    85    80    75    70    65    60
    Verify added measurements    2077-01-01    100    95    90    85    80    75    70    65    60
    Choose side menu element    Strona główna
    Verify measurements update on user page    01-01-2077    100    95    90    85    80    75    70    65    60
    Choose side menu element  Statystyki
    Check deleting measurements    2077-01-01
    Close browser

Check adding, setting active, executing and deleting training plan
    [Tags]    test
    [Documentation]    This test verifies that adding new training plan, setting it active, executing new training and deleting training plan works.
    Open browser and open gymnote app
    Login with given account
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
    Close browser

Check adding new goal
    [Tags]    test
    [Documentation]    This test tries to add a new goal and verify that it is being displayed correctly in goals subpage.
    Open browser and open gymnote app
    Login with given account
    Choose side menu element    Cele
    Check if goals page is available
    Add new goal    Testing goal    Testing goal description    120    Plecy    Mniejsze/Równe
    Choose side menu element    Cele
    Check if goals page is available
    Verify added goal    Testing goal    Testing goal description
    Close browser