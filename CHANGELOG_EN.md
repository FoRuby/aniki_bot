# Changelog
# v_0.2
* when changing information in the Telegram profile (name, username), it is correctly transferred to the database
* changed the message after the event was closed
* changed user authorization. Now it is carried out by user ID
* updated command /start, /help
* added the ability to call commands in the form /say @GachiBuhgalterBot

# v_0.3
* All business logic is transferred to the Trailblazer framework
* Added /changelog command
* BUG: It is no longer possible to create an event with a past date
* Fixed a bug when the amount of payments for an event for an individual participant became negative
  ## Event Menu:
  * Added Edit button for event editing
  * Added Refresh button to update event information
  ## Edit Event Menu:
  * Added the ability to exclude a participant in the Kick User event
  * Added the ability to change the parameters of the Update event
  * Added the ability to close the Close event
  * The /close_event <id> command is no longer available
  ## User Menu:
  * Added user action form. /me command
  * Added finance display form Finance
  * The /my_finance command is no longer available
  * Added a form for displaying personal statistics Statistic
  * The /my_events command is no longer available
  * Added Debt Compensation Compensation option. Example: user Alice owes user Bob $ 300, user Bob owes user Alice $ 150. After both users select the Compensation command in the user action form, and then select the appropriate debtor (Alice, Bob), the debts of users to each other will change as follows, user Alice owes user Bob $ 150, user Bob owes user Alice $ 0.
  * Added the ability to pay off the debt Refill. Example: user Alice owes user Bob $ 300, user Alice transfers $ 200 to user Bob through the client bank. User Bob executes the Refill command => selects user Alice => indicates the amount received from user Alice.

# v_0.3.1
* Added feedback when executing the Refill command
* Fixed a bug where the amount of debt after executing the Refill command could become negative
* When executing the Finance command, users whose borrowing/credit is equal to zero are no longer displayed
* When executing the Compensation command, when a user is selected, those of them whose borrowing/credit is equal to zero are no longer displayed
* When executing the Refill command, when a user is selected, those of them whose borrowing is equal to zero are no longer displayed

# v_0.3.2
* After creating an event, the event form is fixed in the group header
* After the event is closed, the event form is detached from the group header
* After excluding the user from the event, the list of participants in the parent form will change accordingly
* After changing the event parameters, the event parameters in the parent form will change accordingly
* Fixed a bug when the Refresh button did not work in the event editing form

# v_0.3.3
* Added the /last_event command to display the last event in which the user participated
* Fixed a bug when the /feedback command did not work

# v_0.3.4
* Now, when a payment is added by an event participant, the event bank in the parent form is updated interactively
* Improved user interface with the event edit form (Edit)

# v_0.3.5
* Now, when creating an event, you can use more complex phrases as an event name, for example: /create_event This is the name of a test event 2021-11-11 19:00

# v_0.3.6
* Added README.md