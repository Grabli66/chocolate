require "./*"

class OptionTag < CommonTag
  def initialize(id = "", css = "", text = "", value = "", selected = false, disabled = false)
    super("option", id, css, text) do |x|
      value(value)
      selected(selected)
      disabled(disabled)
      with self yield self
    end
  end

  def value(s)
    add_attr("value", s)
  end

  def selected(s)
    add_attr("selected", s)
  end

  def disabled(s)
    add_attr("disabled", s)
  end
end
