class HeadTag < BaseTag
  include ScriptBuilder

  def initialize(id = "")
    super("head", id) do |x|
      with x yield x
    end
  end

  def title(s)
    BaseTag.new("title", text: s) do |x|  		
  		add_child(x)
    end
  end

	def link(rel, href)
    BaseTag.new("link") do |x|
  		x.add_attr("rel", rel)
  		x.add_attr("href", href)
  		add_child(x)
    end
	end
end
