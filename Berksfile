site :opscode

Dir[File.expand_path(File.join(File.dirname(__FILE__), "test", "cookbooks", "*"))].each do |directory|
  if File.exists?(File.join(directory, "metadata.rb"))
    cookbook File.basename(directory), path: directory
  end
end

