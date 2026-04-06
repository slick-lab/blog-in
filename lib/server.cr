# blog-in - Simple markdown blog API
# Created by: slick_phantom
# License: MIT
# Copyright (c) 2024

require "kemal"
require "json"

require "./auth"
require "./list"
require "./get"
require "./search"
require "./create"
require "./update"
require "./delete"

auth = Auth.new
token = auth.get_or_create_token

# List posts
get "/posts" do |env|
  posts = List.new.posts
  env.response.content_type = "application/json"
  posts.to_json
end

# Get single post
get "/posts/:slug" do |env|
  slug = env.params.url["slug"]
  post = Get.new("#{slug}.md").get_post
  if post.nil?
    env.response.status_code = 404
    "Post not found"
  else
    env.response.content_type = "application/json"
    post.to_json
  end
end

# Search posts
get "/search" do |env|
  query = env.params.query["q"]? || ""
  results = Search.new(query).results
  env.response.content_type = "application/json"
  results.to_json
end

# Admin: create post
post "/admin/posts" do |env|
  provided_token = env.request.headers["X-API-Key"]?
  unless auth.validate_token(provided_token)
    env.response.status_code = 401
    next "Invalid token"
  end

  body = env.request.body.not_nil!.gets_to_end
  data = JSON.parse(body)
  slug = data["slug"].as_s
  content = data["content"].as_s

  success = Create.new("#{slug}.md", content).create_file
  if success
    env.response.status_code = 201
    "Post created"
  else
    env.response.status_code = 409
    "Post already exists"
  end
end

# Admin: update post
put "/admin/posts/:slug" do |env|
  provided_token = env.request.headers["X-API-Key"]?
  unless auth.validate_token(provided_token)
    env.response.status_code = 401
    next "Invalid token"
  end

  slug = env.params.url["slug"]
  content = env.request.body.not_nil!.gets_to_end

  success = Update.new("#{slug}.md", content).update_the_file
  if success
    "Post updated"
  else
    env.response.status_code = 404
    "Post not found"
  end
end

# Admin: delete post
delete "/admin/posts/:slug" do |env|
  provided_token = env.request.headers["X-API-Key"]?
  unless auth.validate_token(provided_token)
    env.response.status_code = 401
    next "Invalid token"
  end

  slug = env.params.url["slug"]
  success = Delete.new("posts/#{slug}.md").delete_post
  if success
    "Post deleted"
  else
    env.response.status_code = 404
    "Post not found"
  end
end

Kemal.run
