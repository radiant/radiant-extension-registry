# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_accents_session',
  :secret      => '8c416febef50638fd41a18cf7bb5ddf85fc5cb81ac76fa82b230b3b64bd84b8d60886ea79aacaaf2fd2e3eebea341b522b0059971aa5e694d985fcded3fcde21'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
