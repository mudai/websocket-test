# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_chat_session',
  :secret      => '0186fa954ae73da614f60119a6825109e9f3f0ec3ac72c66b0362caf55dbca98e1a8d3240c15f0e00bb401f44aec6a7290f40451517b900948d9630ae7d34d9a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
