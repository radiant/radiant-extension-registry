# Methods added to this helper will be available to all templates in the application.
require 'digest/md5'
module ApplicationHelper
  def gravatar_url(email, size=80)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=#{size}&d=wavatar"
  end
end
