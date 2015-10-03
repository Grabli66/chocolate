module ScriptBuilder
	def script(src)
		BaseTag.new("script") do |x|    	
			x.add_attr("src", src)
			add_child(x)
		end
	end
end
