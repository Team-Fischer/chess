# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Chess::Application.config.secret_key_base = 'db966b4567f89691601e001f6655763b045ee9f694c7e2c7dd74a293d03f2c045fdf00098182e5751b495c44be390b870b0c8e6e9ad3efd89accf2834681c4e8'
