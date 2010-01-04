When /^I search for "([^\"]*)"$/ do |text|
  fill_in "q", :with => text
  submit_form "search"
end
