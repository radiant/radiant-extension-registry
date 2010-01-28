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