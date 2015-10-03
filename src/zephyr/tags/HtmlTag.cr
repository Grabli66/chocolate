require "./*"

class HtmlTag < BaseTag
  def initialize
    super("html") do |x|      
      with x yield x
    end
  end

  def body(id = "", css = "", text = "")
    BodyTag.new(id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def head(id = "")
    HeadTag.new do |x|
      add_child(x)
      with x yield x
    end
  end
end
