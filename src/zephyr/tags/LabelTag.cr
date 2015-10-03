require "./*"

class LabelTag < CommonTag
  def initialize(id = "", css = "", for = "")
    super("label", id, css) do |x|
      for(for)
      with self yield self
    end
  end

  def for(s)
    add_attr("for", s)
  end
end
