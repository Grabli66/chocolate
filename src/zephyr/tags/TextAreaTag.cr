require "./*"

class TextAreaTag < CommonTag
  def initialize(id = "", css = "", rows = "", placeholder = "", required = false)
    super("textarea", id, css) do |x|      
      placeholder(placeholder)
      required(required)
      with self yield self
    end
  end

  def rows(s)
    add_attr("rows", s)
  end

  def placeholder(s)
    add_attr("placeholder", s)
  end

  def required(s)
    if s
      add_attr("required", s.to_s)
    end
  end
end
