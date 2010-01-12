Feature: BH 1.0 Read lines from IRC
  In order to read incomming log lines
  As Registrator
  I want to add and delete log lines into the database

  Background:
    Given the database is fresh
    
  @log @add
  Scenario: Registrator sends valid add line
    When Registrator submits line with content "A;123;Cuke4Duke beats Fitnesse a loooong time"
    Then table "FagdagLog" contains:
      | Id | Code | Message                                 |
      | 1  | 123  | Cuke4Duke beats Fitnesse a loooong time |

  @log @delete
  Scenario: Registrator wants to delete messages with a specific code
    Given table "FagdagLog" is inserted with:
      | Id | Code | Message |
      | 1  | 123  | Test 1  |
      | 2  | 124  | Test 2  |
    When Registrator submits line with content "D;123;Test 1"
    Then table "FagdagLog" contains no rows with "Code" "123"

  @log @notifications
  Scenario: Registrator wants to receive notifications when messages are received
    Given Registrator expects "1" notification
    When Registrator submits line with content "A;123;Does anyone want a cukie?"
    Then notifications have been sent

  

