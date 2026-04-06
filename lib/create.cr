# blog-in - Simple markdown blog API
# Created by: slick_phantom
# License: MIT
# Copyright (c) 2024
class Create 
  def initialize(file_name : String, content : String)
    @file_name = file_name 
    @content = content 
    create_file 
  end 

  def create_file 
    final_file = "posts/#{@file_name}"
      spawn 
        if File.exists?(final_file)
           return false 
        else
         File.write(final_file, @content)
          return true 
       end 
     end 
   end 
end 
    
