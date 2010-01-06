Feature: Homepage
  In order to discover and manage new extensions
  As an Radiant user
  I want to be able to search for extensions from the homepage and see authors and extensions
  
  Scenario: When I search I should find extensions based on name
    Given an extension "bespin_editor" owned by "John"
    And I am on the homepage
    When I search for "bespin"
    Then I should see "bespin_editor"
  
  Scenario: When I am on the home page I should see a list of extensions
    Given an extension "bespin_editor" owned by "John"
    And an extension "page_attachments" owned by "Sean"
    And an extension "help" owned by "Jim"
    Given I am on the homepage
    Then I should see "bespin_editor"
    And I should see "page_attachments"
    And I should see "help"
  
  Scenario: More Extensions
    Given I am on the homepage
    When I follow "More Extensions"
    Then I should be on the extensions page
  
  Scenario: When I am on the home page I should see a list of authors
    Given authors "John", "Sean", and "Jim"
    And an extension "bespin_editor" owned by "John"
    And an extension "page_attachments" owned by "Sean"
    And an extension "help" owned by "Jim"
    And I am on the homepage
    Then I should see "John"
    And I should see "Sean"
    And I should see "Jim"
  
  Scenario: More Authors
    Given I am on the homepage
    When I follow "More Authors"
    Then I should be on the authors page