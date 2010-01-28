atom_feed do |feed|
  feed.title("Radiant Extension Registry")
  feed.updated((@extensions.first.created_at))
  for extension in @extensions
    feed.entry(extension) do |entry|
      entry.title(extension.name)
      entry.summary(textilize(extension.description), :xhtml => true)
      entry.author(extension.author.name_or_login)
    end
  end
end
