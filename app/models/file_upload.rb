class FileUpload < ActiveRecord::Base  
  # this model is currently not being used but it's a good example of how to 
  # use file_column, which we can potentially use for other stuff like personalized images, etc.
  
  # custom_dir is a custom function for building the relative path the saved file.
  # uploaded files will be in RAILS_ROOT\uploads\(fileupload.id)\filename.
  # the default root was under public with a unnecessarily large path tree

  file_column :filename, :root_path => File.join(RAILS_ROOT, "uploads"), :store_dir => :custom_dir

  def custom_dir
    ""
  end
  
end
