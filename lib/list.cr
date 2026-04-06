class List
  getter posts : Array(Hash(String, String | Int64))

  def initialize
    @posts = list_posts
  end

  private def list_posts : Array(Hash(String, String | Int64))
    dir = "posts"
    posts = [] of Hash(String, String | Int64)

    # Ensure directory exists
    Dir.mkdir_p(dir)

    Dir.entries(dir).each do |entry|
      file_path = File.join(dir, entry)

      if File.file?(file_path) && file_path.ends_with?(".md")
        slug = File.basename(file_path, ".md")
        stat = File.info(file_path)

        posts << {
          "slug"    => slug,
          "created" => stat.modification_time.to_s,
          "size"    => stat.size
        }
      end
    end

    posts
  end
end

