abstract class View
	@cache = nil	

	def render
	end

	def get_html
		unless @cache
		 	@cache = "<!DOCTYPE html>" + render.not_nil!.render
		end		
		@cache.not_nil!
	end
end
