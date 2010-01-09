# Methods added to this helper will be available to all templates in the application.
require 'digest/md5'
module ApplicationHelper
  
  # Returns a Gravatar URL associated with the email parameter.
  # See: http://douglasfshearer.com/blog/gravatar-for-ruby-and-ruby-on-rails
  def gravatar_url(email, options={})
    # Default to highest rating. Rating can be one of G, PG, R X.
    options[:rating] ||= "G"
  
    # Default size of the image.
    options[:size] ||= "80"
  
    # Default image url to be used when no gravatar is found
    # or when an image exceeds the rating parameter.
    options[:default] ||= "http://#{request.host}:#{request.port}/images/avatar_#{([options[:size].to_i] * 2).join('x')}.png"
  
    # Build the Gravatar url.
    url = 'http://www.gravatar.com/avatar.php?'
    url << "gravatar_id=#{Digest::MD5.new.update(email)}" 
    url << "&rating=#{options[:rating]}" if options[:rating]
    url << "&size=#{options[:size]}" if options[:size]
    url << "&default=#{options[:default]}" if options[:default]
    url
  end
  
  def content_for?(symbol)
    !(get_content_for(symbol)).nil?
  end
  
  def get_content_for(symbol)
    instance_variable_get("@content_for_#{symbol}")
  end
  
  def pagination_for(model)
    will_paginate model, :previous_label => "&laquo; Prev", :next_label => "Next &raquo;"
  end
  
  def record_count_for(array, klass)
    size = array.size
    count = klass.count
    if count > size
      "#{size} of #{pluralize(count, klass.name.downcase)}"
    else
      pluralize(count, klass.name.downcase)
    end
  end
  
end