# Ideally this step should not be needed but without a default configuration file
# cuke is running into some weird database transaction issue where the record
# is created but the self.stored_preferences.build({}).owner is returning nil
# This step fixes it
Given /^default configuration file exists$/ do
  AppConfiguration.find_or_create_by_name("Default configuration")
end

Then /^I should see listing shipping methods tabular attributes$/ do
  output = tableish('table#listing_shipping_methods tr', 'td,th')
  data = output[0]
  data[0].should == 'Name'
  data[1].should == 'Zone'
  data[2].should == 'Calculator'
  data[3].should == 'Display'

  data = output[1]
  #data[0].should == Taxonomy.limit(1).order('name asc').to_a.first.name
end

Then /^I should see listing taxonomies tabular attributes$/ do
  output = tableish('table#listing_taxonomies tr', 'td,th')
  data = output[0]
  data[0].should == 'Name'

  data = output[1]
  #data[0].should == Taxonomy.limit(1).order('name asc').to_a.first.name
end

Then /^I should see listing payment methods tabular attributes$/ do
  output = tableish('table#listing_payment_methods tr', 'td,th')
  data = output[0]
  data[0].should == 'Name'
  data[1].should == "Provider"
  data[2].should == "Environment"
  data[3].should == "Display"
  data[4].should == "Active"

  data = output[1]
  #data[0].should == PaymentMethod.limit(1).order('name asc').to_a.first.name
  #data[1].should == PaymentMethod.limit(1).order('name asc').to_a.first.provider
end

Then /^I should see listing states tabular attributes$/ do
  output = tableish('table#listing_states tr', 'td,th')
  data = output[0]
  data[0].should == 'Name'
  data[1].should == "Abbreviation"

  data = output[1]
  data[0].should == State.limit(1).order('name asc').to_a.first.name
  data[1].should == State.limit(1).order('name asc').to_a.first.abbr
end

Given /^existing (.*) records are deleted$/ do |type|
  if type == 'zone'
    Zone.delete_all
  elsif type == 'user'
    User.delete_all
  end
end

Then /^I should see listing zones tabular attributes with (.*)$/ do |order|
  output = tableish('table#listing_zones tr', 'td,th')
  data = output[0]
  data[0].should match(/Name/)
  data[1].should match(/Description/)

  data = output[1]
  data[0].should == Zone.limit(1).order(order).to_a.first.name
  data[0].should == 'eastern' if order == 'name asc'
  data[0].should == 'western' if order == 'description asc'
  data[1].should == Zone.limit(1).order(order).to_a.first.description
end

Then /^I should see listing tax categories tabular attributes$/ do
  output = tableish('table#listing_tax_categories tr', 'td,th')
  data = output[0]
  data[0].should == 'Name'
  data[1].should == "Description"
  data[2].should == "Default"

  data = output[1]
  data[0].should == TaxCategory.limit(1).order('name asc').to_a.first.name
end
