# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# Brss::Application.config.secret_key_base = 'bcc9847bf7546c8e85660f9f942afa0d69c99f9a0c6508d1e30d3b8a443ef955f4895f20ed1080ef7c80b487256e4744cc05423664f299183c4a318d41693b33'
Brss::Application.config.secret_key_base = ENV['SECRET_TOKEN']