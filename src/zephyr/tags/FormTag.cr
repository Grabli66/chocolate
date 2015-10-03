require "./*"

class FormTag < CommonTag
  def initialize(id = "", css = "", action = "", method = "")
    super("form", id, css) do |x|
      action(action)
      method(method)
      with self yield self
    end
  end

  def action(s)
    add_attr("action", s)
  end

  def method(s)
    add_attr("method", s)
  end
end
