Feature: Search
  In order to discover new extensions
  As an Radiant user
  I want to be able to search for extensions
 
  Scenario: When I search I should find extensions based on name
    Given an extension "bespin_editor" owned by "John"
    Given I am on the search page
    When I search for "bespin"
    Then I should see "bespin_editor"
  
  Scenario: When I search I should find extensions based on description
    Given an extension "bespin_editor" owned by "John" with a description of "crazy text editor"
    Given I am on the search page
    When I search for "crazy"
    Then I should see "bespin_editor"