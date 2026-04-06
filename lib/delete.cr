class Delete 
  def initialize(file: String)
    @file = file 
    delete_post
  end 

  def delete_post
    if File.exists?(@file)
      File.delete(@file)
      return trye 
    else 
     return false 
   end 
 end 
end 
  
