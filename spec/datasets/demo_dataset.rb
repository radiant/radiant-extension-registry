class DemoDataset < Dataset::Base
  uses :authors, :extensions
  
  def load
    create_extension("help_use_cases",
      :author_id => author_id(:jim),
      :description => "Adds additional information to the Help extension for particular uses of the standard features."
    )
    create_extension("header_authorize",
      :author_id => author_id(:jim),
      :description => "Header Authorize creates alterations of the Login System to accept Header information for authorization. This allows you to use a central authentication system for multiple applications including Radiant."
    )
    create_extension("admin_breadcrumbs",
      :author_id => author_id(:jim),
      :description => "Adds breadcrumbs to the page edit interface (extended metadata) to provide links to the ancestor pages."
    )
    create_extension("vapor",
      :author_id => author_id(:jim),
      :description => "Manages URL redirects without the need to create useless pages. It will catch every request and test against the ‘catch URLs’ that you provide. It even allows you to redirect to another website."
    )
    create_extension("seo_help",
      :author_id => author_id(:jim),
      :description => "Provides if_meta and unless_meta tags with an inherit attribute to search page ancestors."
    )
    create_extension("blog",
      :author_id => author_id(:jim),
      :description => "Adds tags such as “r:authors” and “r:pages” (for the current author) and pulls in all features from the siblings_tags extension\n\nDevelopment was supported by Ignite Social Media"
    )
    create_extension("wordpress_link_saver",
      :author_id => author_id(:jim),
      :description => "Allows you to maintain imported content to the Radiant database from WordPress. Any existing links such as mysite.com/?p=123 will function properly as long as your pages table has recorded the wordpress_id\n\nSponsored by Braintree Payment Solutions"
    )
    create_extension("application_theme",
      :author_id => author_id(:jim),
      :description => "Provides extensions the ability to alter the Radiant interface without changing the underlying layout. You can use this to append (or completely replace) stylesheets or javascripts used by the interface.\n\nThis means that you can re-style it across the entire application, rather than just in your extension’s controllers or by peppering your view files with include_stylesheet."
    )
    create_extension("help_inline",
      :author_id => author_id(:jim),
      :description => "Provides additional help within the pages of the interface (rather than in a separate tab). This creates a needs_help preference for each user that, when selected, will show tips on using Radiant within the interface.\n\nIt requires that you install application_theme."
    )
    create_extension("dashboard",
      :author_id => author_id(:jim),
      :description => "Provides an area to view recent activity in Radiant. The interface is extendable so that other exensions may add their own recent activity list."
    )
    
    create_author("Andrea", :last_name => "Franz", :website => "http://gravityblast.com")
    create_extension("gallery",
      :author_id => author_id(:andrea),
      :description => "The Gallery extension allows Radiant to manage galleries of images."
    )
    create_extension("copy_move",
      :author_id => author_id(:andrea),
      :description => "It allows for a page to be copied (or moved) under a new parent"
    )
    
    create_author("Michael", :last_name => "Klett", :website => "http://webadvocate.com")
    create_extension("nested_layouts",
      :author_id => author_id(:aaron),
      :description => "Nested Layouts enables reuse of a top-level “master” layout (one that contains your tags and the overall structure/wrapper of your site) for several different “nested” layouts (i.e. a one-column layout and a two-column layout). Keep your layouts DRY!"
    )
    
    create_author("Andrew", :last_name => "vonderLuft", :login => "avonderluft", :website => "http://avlux.net", :notes => "Radiant Web Host, Admin & Developer")
    create_extension("concurrent_draft",
      :author_id => author_id(:andrew),
      :description => "Enables default draft versions of pages, snippets and layouts, which can be scheduled for promotion to Production. Radiant 0.7 compliant."
    )
    create_extension("page_list_view",
      :author_id => author_id(:andrew),
      :description => "Enables viewing site pages in a list views sortable by attibute, either full list or a paginated list. trunk is compatible with 0.7.0 or higher; tag 1.1 is compatible with 0.6.9\n\nRequires will_paginate plugin: After install, from extension directory run:\n$ git submodule init && git submodule update"
    )
    
    create_author("Keith", :last_name => "Bingman", :login => "kbingman")
    create_extension("paperclipped",
      :author_id => author_id(:keith),
      :description => 'Assets manager for Radiant based on "Paperclip":http://thoughtbot.com/projects/paperclip with support for multiple file types and drag and drop insertion into Radiant pages.'
    )
    
    create_author("Todd", :last_name => "Willey", :login => "xtoddx")
    create_extension("beastly",
      :author_id => author_id(:todd),
      :description => "Allows RadiantCMS to share users and layouts with Altered Beast forum software. See project’s README file for more information and instructions on required plugins for your beast installation."
    )
    
    create_author("Stefan", :last_name => "Kroes", :website => "http://www.nedforce.nl")
    create_extension("escape_xml",
      :author_id => author_id(:stefan),
      :description => "This extension adds the r:escape_xml tag to escape predefined XML characters."
    )
    
    create_author("Jason", :last_name => "Garber", :website => "http://radiantcmshosting.com", :notes => 'I use Radiant *a lot*, both in my work at "EMU":http://www.emu.edu/ and in hosting websites for a number of private clients.', :available_for_hire => true)
    create_extension("redcloth4",
      :author_id => author_id(:jason),
      :description => "Enable RedCloth 4.0.3 or greater from RubyGems. RedCloth 3.0.4 comes packaged with Radiant <= 0.6.9, so we have to pull some tricks to get RedCloth loaded from gems. Not needed with Radiant 0.7 and above."
    )
    create_extension("textile_editor",
      :author_id => author_id(:jason),
      :description => "Adds a toolbar when the Textile filter is selected to make it easier to apply Textile formatting. If you have enkoder_tags and page_attachments extensions installed, the link and image buttons also assist you in inserting mailtos, links to attachments, and attached images."
    )
    create_extension("page_attachments_xsendfile",
      :author_id => author_id(:jason),
      :description => "Works with the page_attachments extension to make attached files available under the page they’re attached to, so the URL of an attachment can be pretty and also located where it belongs in the heirarchy (/sales/agreement.pdf instead of /page_attachments/0000/0001/agreement.pdf)"
    )
    create_extension("vhost",
      :author_id => author_id(:jason),
      :description => "This extension allows you to host multiple separate sites with their own pages, snippets, and layouts on the same Radiant instance. Everything is scoped to the site, so you must log in separately at each domain. Thus, you can host multiple clients’ sites and they don’t know they don’t have their own instance."
    )
    create_extension("chronicle",
      :author_id => author_id(:jason),
      :description => "This extension adds versioning to pages and uses a page’s status to determine its visibility. The most recent published or hidden version is visible in live mode and the most recent version, a.k.a. the “current version,” is visible in dev mode regardless of its status. Thus, you can work on a draft in dev mode, preview exactly how it will look, and then make it live when you are ready by changing its status to published. Also shows diffs between versions."
    )
    create_extension("no_dev_cache",
      :author_id => author_id(:jason),
      :description => "When caching was switched to Rack::Cache in Radiant 0.8, the bit where it wouldn’t cache in dev mode was left out. This puts it back in. Not needed in Radiant 0.9."
    )
  end
end