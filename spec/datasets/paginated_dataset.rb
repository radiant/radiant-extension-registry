class PaginatedDataset < Dataset::Base
  uses :authors, :extensions
  
  def load
    (1..100).each do |number|
      create_extension("extension_#{number}",
        :name => "Extension #{number}",
        :author_id => author_id(:seancribbs, :aaron, :jlong, :saturnflyer).rand,
        :description => "This extension's number #{number}"
      )
    end
    (1..35).each do |number|
      author = create_author("thing_#{number}", :name => "Thing #{number}")
      create_extension("extension_#{(1 * number) + 100}",
        :name => "Extension #{(1 * number) + 100}",
        :author_id => author.id,
        :description => "This extension's number #{(1 * number) + 100}"
      )
    end
  end
end