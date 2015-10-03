require "./*"

class InputTag < CommonTag
  def initialize(id = "", css = "", type = "text", placeholder = "", required = false, name = "")
    super("input", id, css) do |x|
      type(type)
      placeholder(placeholder) unless placeholder.empty?
      required(required) if required
      name(name) unless name.empty?
      with self yield self
    end
  end

  def type(s)
    add_attr("type", s)
  end

  def name(s)
    add_attr("name", s)
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
