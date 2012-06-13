desc "Create sprites for the flat HTML files"
task :sprite do 
	require 'sprite_factory'
	if File.exists? "assets/css/modules.css"
		system %Q{rm "assets/css/modules.css"}
	end
	modules = ""
	Dir["./assets/images/\*/"].each do |dir|
		bdir = File.basename(dir)
		SpriteFactory.run!(dir, {:selector => ".", :hmargin => 20, :csspath => "../../images", :nocomments => true })
		system %Q{mv "assets/images/#{bdir}.css" "assets/css/modules/#{bdir}.css"}
		modules << "@import url(\"modules/#{bdir}.css\");\n"
	end
	file = File.new("assets/css/modules.css", "w")
	file.write(modules)
    file.close
end