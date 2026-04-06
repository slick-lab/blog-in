class Get
  def initialize(file_name : String)
    @file_name = file_name
    get_post
  end

  def get_post
    file = "posts/#{@file_name}"
    if File.exists?(file)
      content = File.read(file)
      {
        "name"    => @file_name,
        "content" => content,
        "version" => "1.0.0"
      }
    else
      false
    end
  end
end
