Feature: Extensions
  In order to share extensions
  As a user with an account
  I want to add, edit, and view extensions
 
  Scenario: When I create an extension it should have a page in the registry
    Given I am logged in as "John"
    Given I am on the extension listing
    When I follow "Add Extension"
    Then I should be on the new extension page
    When I fill in the following:
      | Extension Directory Name  | ember                         |
      | Version                   | 0.1                           |
      | Radiant Version           | 0.9                           |
      | Homepage                  | http://github.com/john/ember  |
      | Repository                | git@github.com/john/ember.git |
    And I select "Git" from "Type"
    And I press "Add Extension"
    Then I should see "Created successfully!"
  
  Scenario: I should be able to edit extensions I created
    Given I am logged in as "John"
    And there is an extension "ember" owned by "John"
    And I am viewing all extensions
    When I follow "ember"
    And I follow "edit"
    Then I should see "Edit Extension"
  
  Scenario: I should not be able to edit extensions I did not create
    Given I am logged in as "John"
    And there is an extension "ember" owned by "Sean"
    And I am viewing all extensions
    When I follow "ember"
    Then I should not see "edit"
  
  Scenario: I should be able to edit extensions I did not create if I am a manager
    Given I am logged in as "John"
    And I am a manager
    And there is an extension "ember" owned by "Sean"
    And I am viewing all extensions
    When I follow "ember"
    And I follow "edit"
    Then I should see "Edit Extension"