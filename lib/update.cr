class Update
  def initialize(filename : String, new_content : String)
    @filename = filename
    @new_content = new_content
    update_the_file
  end

  def update_the_file
    file = "posts/#{@filename}"
    if File.exists?(file)
      File.write(file, @new_content) # overwrite file
      true
    else
      false
    end
  end
end

