Given /^an author "([^\"]*)"$/ do |name|
  login = name.downcase.gsub(" ", "_")
  attributes = {
    :first_name => name,
    :login => login,
    :email => "#{login}@example.com",
    :password => "test",
    :password_confirmation => "test",
    :available_for_hire => [true, false].rand
  }
  Author.create!(attributes)
end

Given /^an extension "([^\"]*)" owned by "([^\"]*)"$/ do |name, author|
  slug = name.downcase.gsub(" ", "-")
  attributes = {
    :name => name,
    :repository_url => "git://github.com/seancribbs/radiant-#{slug}-extension.git",
    :description => "(none)",
    :download_url => nil,
    :author_id => Author.find_by_first_name(author),
    :repository_type => "Git",
    :homepage => "http://github.com/seancribbs/radiant-#{slug}-extension",
    :current_version => "1.0.0",
    :supports_radiant_version => "0.7.1"
  }
  Extension.create!(attributes)
end
