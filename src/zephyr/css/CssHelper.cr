class CssHelper
	def initialize()
		@classList = [] of String
	end

	def initialize(cs)
		@classList = cs.split(" ")
	end

	def add_class(c)
		cls = c.split(" ")
		cls.each do |x|
			unless @classList.includes?(x)
				@classList.push(x)
			end
		end
	end

	def remove_class(c)
		cls = c.split(" ")
		cls.each do |x|
			@classList.delete(x)
		end
	end

	def clear()
		@classList.clear
	end

	def to_s
		@classList.join(" ")
	end
end
