Feature: Search
  In order to discover new extensions
  As an information seeker
  I want to be able to search for extensions
 
  Scenario: Find what I'm looking for
    Given an extension "bespin_editor" owned by "John"
    Given I am on the search page
    When I search for "bespin"
    Then I should see "bespin_editor"
  
  Scenario: Find what I'm looking for
    Given an extension "bespin_editor" owned by "John" with a description of "crazy text editor"
    Given I am on the search page
    When I search for "crazy"
    Then I should see "bespin_editor"