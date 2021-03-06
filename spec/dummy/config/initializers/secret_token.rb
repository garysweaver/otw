# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

# test app, so just using short random-ish key, because was easy. don't do this for real.

# rails 3
Dummy::Application.config.secret_token = SecureRandom.urlsafe_base64 * 3

# rails 4+
Dummy::Application.config.secret_key_base = SecureRandom.urlsafe_base64 * 3
