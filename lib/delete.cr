# blog-in - Simple markdown blog API
# Created by: slick_phantom
# License: MIT
# Copyright (c) 2024
class Delete 
  def initialize(file: String)
    @file = file 
    delete_post
  end 

  def delete_post
  if File.exists?(@file)
    begin
      File.delete(@file)
      true
    rescue ex
      puts "Error deleting file: #{ex.message}"
      false
    end
  else
    false
  end
 end
end 
