abstract class View
	def render
	end

	def get_html
		"<!DOCTYPE html>" + render.not_nil!.render
	end
end
