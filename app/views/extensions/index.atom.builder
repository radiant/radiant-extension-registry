atom_feed do |feed|
  feed.title("Radiant Extension Registry")
  feed.updated((@extensions.first.created_at))
  for extension in @extensions
    feed.entry(extension) do |entry|
      entry.title(extension.name)
      entry.summary(extension.description)
      entry.author(extension.author.first_name + " " + extension.author.last_name)
    end
  end
end
