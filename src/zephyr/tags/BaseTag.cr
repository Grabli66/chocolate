require "../css/*"

class Array(T)
	def render
		str = [] of String
		self.each do |x|
			str << x.render
		end
		str.join("")
	end
end

class BaseTag
	@childs = [] of BaseTag
	@tag = ""
	@attrs = Hash(String,String).new
  @text = ""

	def initialize(@tag, id = "", css = "", text = "")
		id(id) unless id.empty?
    css_add(css) unless css.empty?
    text(text) unless text.empty?
		with self yield self
	end

	def id(s : String)
		add_attr("id", s)
	end

  def tag(s : String)
    @tag = s
  end

	def add_child(c)
		@childs << c
	end

	def add_attr(k, v)
		@attrs[k] = v
	end

	def css_add(s)
		c = @attrs["class"]?

		if c
			add_attr("class", c)
		else
			ch = CssHelper.new()
			ch.add_class(s)
			add_attr("class", ch.to_s)
		end
	end

	def css_remove()
		c = @attrs["class"]?
		if c
			ch = CssHelper.new(c)
			ch.remove_class(s)
			add_attr("class", ch.to_s)
		end
	end

  def text(s)
    @text = s
  end

	def data(k, v)
		add_attr("data-#{k}", v)
	end

	def include_element(e)
		add_child(e)
	end

	def include_view(e)
		add_child(e.render)
	end

	def render
  	if @attrs.size > 0
  		a = [] of String
  		@attrs.each do |k, v|
  			a << %(#{k}="#{v}")
  		end
  		s = a.join(" ")
  		return %(<#{@tag} #{s}>#{@text}#{@childs.render}</#{@tag}>)
  	else
  		return %(<#{@tag}>#{@text}#{@childs.render}</#{@tag}>)
  	end
	end
end
