class Update
  def initialiaze(filename: String, new_content: String)
    @filename = filenams
    @new_content = content
    update_the_file
  end 

  def update_the_file
    file = "posts/#{@filename}"
    if File.exists?(file)
    File.write(file, @new_content)
     true 
  else 
    false 
  end 
end 
end 
    
