def create_author(name, attributes = {})
  login = name.split(" ", 2).first.downcase.gsub(" ", "_")
  attributes = {
    :name => name,
    :login => login,
    :email => "#{login}@example.com",
    :password => "test",
    :password_confirmation => "test",
    :available_for_hire => [true, false].rand
  }.merge(attributes)
  Author.create!(attributes)
end

Given /^an author "([^\"]*)"$/ do |name|
  create_author(name)
end

Given /^authors (".*")$/ do |authors|
  authors = authors.gsub(/[" ]|and/, '').split(",")
  authors.each do |name|
    create_author(name)
  end
end

Given /^I am logged in as "([^\"]*)"$/ do |name|
  Given "I am on the login page"
  @current_user = create_author(name)
  fill_in("login", :with => @current_user.login)
  fill_in("password", :with => @current_user.password)
  click_button("Login")
end

Given /^I am a manager$/ do
  @current_user.manager = true
  @current_user.save!
end