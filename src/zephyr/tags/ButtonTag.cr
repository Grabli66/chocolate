require "./*"

class ButtonTag < CommonTag
  def initialize(id = "", css = "", text = "", type = "button")
    super("button", id, css, text) do |x|
      type(type)
      with self yield self
    end
  end

  def type(s)
    add_attr("type", s)
  end
end
