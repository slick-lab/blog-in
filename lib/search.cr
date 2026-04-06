# blog-in - Simple markdown blog API
# Created by: slick_phantom
# License: MIT
# Copyright (c) 2024

class Search
  def initialize(query : String)
    @query = query.downcase
    @results = search_posts
  end

  getter results : Array(Hash(String, String))

  private def search_posts : Array(Hash(String, String))
    dir = "posts"
    results = [] of Hash(String, String)

    return results unless Dir.exists?(dir)

    Dir.entries(dir).each do |entry|
      file_path = File.join(dir, entry)

      if File.file?(file_path) && file_path.ends_with?(".md")
        slug = File.basename(file_path, ".md")
        content = File.read(file_path)
        lower_content = content.downcase

        # Search in slug and content
        if slug.includes?(@query) || lower_content.includes?(@query)
          stat = File.info(file_path)

          # Title from first line or slug
          title = slug.gsub("-", " ")
          first_line = content.lines.first?
          if first_line && first_line.starts_with?("#")
            title = first_line.gsub("#", "").strip
          end

          excerpt = content[0, content.size > 100 ? 100 : content.size]

          results << {
            "slug"    => slug,
            "title"   => title,
            "created" => stat.modification_time.to_s,
            "excerpt" => excerpt
          }
        end
      end
    end

    results
  end
end
