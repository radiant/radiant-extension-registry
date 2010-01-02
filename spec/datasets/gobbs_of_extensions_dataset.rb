class GobbsOfExtensionsDataset < Dataset::Base
  uses :extensions
  
  def load
    (1..100).each do |number|
      create_extension(number.to_s,
        :author_id => author_id(:sean, :aaron, :john, :jim).rand,
        :description => "This extension's number #{number}",
        :repository_url => "#{number}"
      )
    end
  end
end