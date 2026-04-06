# Inkwell - Simple markdown blog API
# Created by: slick_phantom
# License: MIT
# Copyright (c) 2024

require "base64"
require "random"

class Auth
  TOKEN_FILE = "admin.token"

  # Get or create a token
  def get_or_create_token : String
    if File.exists?(TOKEN_FILE)
      return File.read(TOKEN_FILE).strip
    end

    # Generate new token
    random = Random::Secure.new
    bytes = Array.new(32) { random.rand(0..255).to_u8 }
    token = "ink_#{Base64.urlsafe_encode(bytes)}"

    File.write(TOKEN_FILE, token)

    puts "\n" + "=" * 50
    puts "🔑 FIRST RUN DETECTED"
    puts "Save this token: #{token}"
    puts "Use it in X-API-Key header for admin requests"
    puts "=" * 50 + "\n"

    token
  end

  # Validate a token
  def validate_token(token : String?) : Bool
    return false if token.nil? || token.empty?
    return false unless File.exists?(TOKEN_FILE)

    stored_token = File.read(TOKEN_FILE).strip
    stored_token == token.strip
  end
end

