Given /^an extension "([^\"]*)" owned by "([^\"]*)"(?: with a description of "([^\"]*)"|)$/ do |name, author, description|
  slug = name.downcase.gsub(" ", "-")
  author = Author.find_by_first_name(author) || create_author(author)
  attributes = {
    :name => name,
    :repository_url => "git://github.com/seancribbs/radiant-#{slug}-extension.git",
    :description => description || "(none)",
    :download_url => nil,
    :author_id => author.id,
    :repository_type => "Git",
    :homepage => "http://github.com/seancribbs/radiant-#{slug}-extension",
    :current_version => "1.0.0",
    :supports_radiant_version => "0.7.1"
  }
  Extension.create!(attributes)
end
