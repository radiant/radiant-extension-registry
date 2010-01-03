Feature: Search
  In order to discover new extensions
  As an information seeker
  I want to be able to search for extensions
 
  Scenario: Find what I'm looking for
    Given an author "John"
    And an extension "bespin_editor" owned by "John"
    And I am on the search page
    When I search for "bespin"
    Then I should see "bespin_editor"