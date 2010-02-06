atom_feed do |feed|
  feed.title("Radiant Extension Registry")
  feed.updated((@extensions.first.created_at))
  for extension in @extensions
    feed.entry(extension) do |entry|
      entry.title(extension.name)
      entry.summary(extension.description, :type => 'text')
      entry.author do |author|
        author.name(extension.author.name_or_login)
      end
    end
  end
end
