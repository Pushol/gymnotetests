*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${siteUrl}    http://localhost:8080/
${browser}    Chrome

*** Keywords ***
Open browser and open gymnote app
    [Documentation]    This keyword opens browser and goes to gymnote app.
    Open Browser    ${siteUrl}    ${browser}
    Maximize Browser Window
    Wait until keyword succeeds    30    1s    Page Should Contain    Co oferujemy?

Go to register form
    [Documentation]    This keyword goes from starting page to register form.
    Click Element    xpath://a[contains(text(),"Zarejestruj się")]
    Wait until keyword succeeds    30    1s    Page Should Contain    Masz już konto?

Fill register form
    [Arguments]    ${login}    ${password}    ${email}
    [Documentation]    This keyword fills register with given arguments.
    Input Text    xpath://input[@id="username"]    ${login}
    Input Text    xpath://input[@id="email"]    ${email}
    Input Password    xpath://input[@id="password"]    ${password}
    Input Password    xpath://input[@id="passwordRetry"]    ${password}

Fill and submit register form
    [Arguments]    ${login}    ${password}    ${email}
    [Documentation]    This keyword fills register with given arguments and sends form.
    Fill register form  ${login}    ${password}    ${email}
    Click Button    xpath://input[@value="Zarejestruj się"]
    Wait until keyword succeeds    30    1s    Page Should Contain    Wypełnij to pole
    Wait until keyword succeeds    30    1s    Page Should Contain    Błąd rejestracji

Fill login form
    [Arguments]    ${login}    ${password}
    [Documentation]    This keyword fills login form.
    Input Text    xpath://input[@id="username"]    ${login}
    Input Password    xpath://input[@id="password"]    ${password}

Login with given account
    [Arguments]    ${login}=test1    ${password}=test1
    [Documentation]    This keyword tries to login with given account into gymnote app. If no arguments are given, keyword will use test account.
    Fill login form  ${login}    ${password}
    Click Button    xpath://input[@value="Zaloguj się"]

Fill and submit measurements form
    [Arguments]    ${date}    ${weight}    ${forearm}    ${arm}    ${shoulders}    ${chest}    ${waist}    ${glutes}    ${thigh}    ${calf}
    [Documentation]    This keyword fills measurements form with given arguments.
    Input Text    xpath://input[@id='date']    ${date}
    Input Text    xpath://input[@id="weight"]    ${weight}
    Input Text    xpath://input[@id="forearm"]    ${forearm}
    Input Text    xpath://input[@id="arm"]    ${arm}
    Input Text    xpath://input[@id="shoulders"]    ${shoulders}
    Input Text    xpath://input[@id="chest"]    ${chest}
    Input Text    xpath://input[@id="waist"]    ${waist}
    Input Text    xpath://input[@id="glutes"]    ${glutes}
    Input Text    xpath://input[@id="thigh"]    ${thigh}
    Input Text    xpath://input[@id="calf"]    ${calf}
    Click Element    xpath://input[@id="saveMeasurementsButton"]
    Wait until keyword succeeds    30    1s    Page Should Contain    Pomyślnie dodano pomiary

Verify added measurements
    [Arguments]    ${date}    ${weight}    ${forearm}    ${arm}    ${shoulders}    ${chest}    ${waist}    ${glutes}    ${thigh}    ${calf}
    [Documentation]    This keyword verifies that added measurements are displayed correctly.
    Page Should Contain    ${date}
    Click Element    xpath://div[contains(text(),"${date}")]
    Page Should Contain    Waga: ${weight} kg
    Page Should Contain    Obwód przedramienia: ${forearm} cm
    Page Should Contain    Obwód w bicepsie: ${arm} cm
    Page Should Contain    Obwód w barkach: ${shoulders} cm
    Page Should Contain    Obwód w klatce: ${chest} cm
    Page Should Contain    Obwód w pasie: ${waist} cm
    Page Should Contain    Obwód w pośladkach: ${glutes} cm
    Page Should Contain    Obwód w udzie: ${thigh} cm
    Page Should Contain    Obwód w łydce: ${calf} cm

Verify measurements update on user page
    [Arguments]    ${date}    ${weight}    ${forearm}    ${arm}    ${shoulders}    ${chest}    ${waist}    ${glutes}    ${thigh}    ${calf}
    [Documentation]    This keyword verifies that measurements are updated on user main page.
    Page Should Contain    ${date}
    Page Should Contain    Waga: ${weight} kg
    Page Should Contain    Obwód przedramienia: ${forearm} cm
    Page Should Contain    Obwód w bicepsie: ${arm} cm
    Page Should Contain    Obwód w barkach: ${shoulders} cm
    Page Should Contain    Obwód w klatce: ${chest} cm
    Page Should Contain    Obwód w pasie: ${waist} cm
    Page Should Contain    Obwód w pośladkach: ${glutes} cm
    Page Should Contain    Obwód w udzie: ${thigh} cm
    Page Should Contain    Obwód w łydce: ${calf} cm

Add new training plan
    [Arguments]    ${trainingPlanName}    ${exerciseName}    ${exerciseName2}
    [Documentation]    This keyword tries to add new training plan and verifies that it has been done properly.
    Click Button    xpath://button[@id="addNewTrainingPlan"]
    Wait Until Element Is Visible    xpath://button[@id="trainingRemove"]
    Click Button    xpath://button[@id="trainingRemove"]
    Click Button    xpath://button[@id="trainingRemove"]
    Input Text    xpath://input[@id='newTrainingPlanName']    ${trainingPlanName}
    Click Button    xpath://button[@id="trainingAccept"]
    Wait Until Element Is Visible    xpath://input[@id="exerciseNameInput0"]
    Input Text    xpath://input[@id='exerciseNameInput0']    ${exerciseName}
    Click Element   xpath=//select[@id="selectedMuscle0"]
    Wait Until Element Is Visible   xpath=//option[contains(text(),'Ramiona')]
    Click Element   xpath=//option[contains(text(),'Ramiona')]
    Input Text    xpath://input[@id='seriesValue0']    2
    Input Text    xpath://input[@id='repeatsMinValue0']    5
    Input Text    xpath://input[@id='repeatsMaxValue0']    10
    Click Button    xpath://button[@class="addButton trainingButton"]
    Wait Until Element Is Visible    xpath://input[@id="exerciseNameInput1"]
    Input Text    xpath://input[@id='exerciseNameInput1']    ${exerciseName2}
    Input Text    xpath://input[@id='seriesValue1']    3
    Input Text    xpath://input[@id='repeatsMinValue1']    5
    Input Text    xpath://input[@id='repeatsMaxValue1']    10
    Click Button    xpath://button[@onclick='saveNewPlan()']
    Wait until keyword succeeds    30    1s    Page Should Contain    Dodano plan treningowy

Verify added training plan
    [Arguments]    ${trainingPlanName}
    [Documentation]    This keyword verifies that given training plan is displayed in trainings subpage.
    Click Button    xpath://button[@id="showPlans"]
    Wait until keyword succeeds    30    1s    Page Should Contain    ${trainingPlanName}

Set training plan active
    [Arguments]    ${trainingPlanName}
    [Documentation]    This keyword tries to training plan to active.
    Wait Until Element Is Visible    xpath://button[text()='${trainingPlanName}']
    ${trainingPlanId}=   Get Element Attribute  xpath://button[text()='${trainingPlanName}']  id
    Click Button    xpath://button[text()='${trainingPlanName}']
    Wait Until Element Is Visible    xpath://input[@value='Aktywuj plan' and @id='${trainingPlanId}']
    Wait until keyword succeeds    30    1s    Click Element    xpath://input[@value='Aktywuj plan' and @id='${trainingPlanId}']
    Sleep    5s
    Wait until keyword succeeds    30    1s    Page Should Contain    Aktywowano nowy plan!

Add executed training
    [Arguments]    ${firstExerciseWeight}    ${firstExerciseReps}
    [Documentation]    This keyword tries to add new executed training and verifies that it has been done properly.
    Click Button    xpath://button[@id="addNewTraining"]
    Wait Until Element Is Visible    xpath://button[@class="trainingPlanViewButton"]
    Click Button    xpath://button[@class="trainingPlanViewButton"]
    Wait Until Element Is Visible    xpath://div[@class="acceptTraining"]
    Click Element   xpath=//div[@id="1testTrainingExercise1"]
    Wait Until Element Is Visible    xpath://input[@name="weight"]
    Input Text    xpath://input[@name="weight"]    ${firstExerciseWeight}
    Input Text    xpath://input[@name="reps"]    ${firstExerciseReps}
    Wait until keyword succeeds    30    1s    Click Button    xpath://button[@id='saveTrainingButton']
    Wait until keyword succeeds    30    1s    Page Should Contain    Dodano nowy trening!

Delete training plan
    [Arguments]    ${trainingPlanName}
    [Documentation]    This keyword tries to delete training plan and verifies that it has been done properly.
    Click Button    xpath://button[@id="showPlans"]
    Wait until keyword succeeds    30    1s    Page Should Contain    ${trainingPlanName}
    Wait Until Element Is Visible    xpath://button[text()='${trainingPlanName}']
    ${trainingPlanId}=   Get Element Attribute  xpath://button[text()='${trainingPlanName}']  id
    Click Button    xpath://button[text()='${trainingPlanName}']
    Wait Until Element Is Visible    xpath://input[@value='Usuń plan' and @id='${trainingPlanId}']
    Wait until keyword succeeds    30    1s    Click Element    xpath://input[@value='Usuń plan' and @id='${trainingPlanId}']
    Sleep    5s
    Wait until keyword succeeds    30    1s    Page Should Contain    Usunięto wybrany plan!

Verify that training plan has been deleted
    [Arguments]    ${trainingPlanName}
    [Documentation]    This keyword verifies that training plan has been deleted from training plan list.
    Click Button    xpath://button[@id="showPlans"]
    Wait until keyword succeeds    30    1s    Page Should Not Contain    ${trainingPlanName}

Verify active training plan on user page
    [Arguments]    ${trainingPlanName}
    [Documentation]    This keyword verifies that given training plan is updated od user page.
    Wait until keyword succeeds    30    1s    Wait Until Element Is Visible    xpath://div[@class='trainingContainerContent']/p[text()='${trainingPlanName}']

Check deleting measurements
    [Arguments]    ${date}
    [Documentation]    This keyword verifies that deleting measurements is done properly.
    Page Should Contain    ${date}
    Click Element    xpath://div[contains(text(),"${date}")]//span[@class='material-icons']
    Wait until keyword succeeds    30    1s    Page Should Contain    Pomyślnie usunięto wybrane pomiary

Choose side menu element
    [Arguments]    ${element}
    [Documentation]    Keyword chooses element in side menu. Use text visible on the button.
    Wait until keyword succeeds    30    1s    Click Element    xpath://a[contains(text(),"${element}")]

Check if settings page is available
    [Documentation]    Keyword checks that settings subpage is available.
    Wait until keyword succeeds    30    1s    Page Should Contain    Zmień hasło

Check if deficit calculator page is available
    [Documentation]    Keyword checks that deficit calculator subpage is available.
    Wait until keyword succeeds    30    1s    Page Should Contain    Kalkulator deficytu umożliwia ustalić

Check if goals page is available
    [Documentation]    Keyword checks that goals subpage is available.
    Wait until keyword succeeds    30    1s    Page Should Contain    Wyświetl cele

Check if training page is available
    [Documentation]    Keyword checks that training subpage is available.
    Wait until keyword succeeds    30    1s    Page Should Contain    Dodaj trening

Check if statistics page is available
    [Documentation]    Keyword checks that training subpage is available.
    Wait until keyword succeeds    30    1s    Page Should Contain    Nie jest wymagane podawanie wszystkich pomiarów

Add new goal
    [Arguments]    ${goalName}    ${goalDescription}    ${goalValue}    ${goalBodyPart}    ${goalType}
    [Documentation]    Keyword tries to add new goal in goals subpage.
    Wait until keyword succeeds    30    1s    Click Element    xpath://div[text()='Dodaj cele' and @class='switchTab']
    Wait Until Element Is Visible    xpath://input[@value='Zapisz cel' and @id='saveNewGoal']
    Input Text    xpath://input[@id="goal"]    ${goalName}
    Input Text    xpath://input[@id="description"]    ${goalDescription}
    Input Text    xpath://input[@id="value"]    ${goalValue}
    Click Element   xpath=//select[@id="part"]
    Wait Until Element Is Visible   xpath=//option[contains(text(),'${goalBodyPart}')]
    Click Element   xpath=//option[contains(text(),'${goalBodyPart}')]
    Click Element   xpath=//select[@id="type"]
    Wait Until Element Is Visible   xpath=//option[contains(text(),'${goalType}')]
    Click Element   xpath=//option[contains(text(),'${goalType}')]
    Click Element    xpath://input[@value='Zapisz cel' and @id='saveNewGoal']
    Wait until keyword succeeds    30    1s    Page Should Contain    Pomyślnie dodano nowy cel
    Reload page

Verify added goal
    [Arguments]    ${goalName}    ${goalDescription}
    [Documentation]    Keyword verifies that given goal is displayed in goals subpage.
    Wait until keyword succeeds    30    1s    Page Should Contain    ${goalName}
    Wait until keyword succeeds    30    1s    Page Should Contain    ${goalDescription}