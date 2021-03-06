Feature: Admin visiting option types

  Scenario: Visiting admin option types page
    Given 2 option types exist
    And I go to the admin home page
    When I follow "Products"
    When I follow "Option Types"
    Then I should see listing option types tabular attributes

  @javascript
  Scenario: Visiting admin option types page to create new records
    When I go to the admin home page
    When I follow "Products"
    When I follow "Option Types"
    When I follow "new_option_type_link"
    Then I should see "New Option Type" within "#new_option_type"
    When I fill in "option_type_name" with "shirt colors"
    When I fill in "option_type_presentation" with "colors"
    When I press "Create"
    Then I should see "Successfully created!"
    #Then TODO Edit Destroy
