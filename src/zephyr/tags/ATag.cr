require "./*"

class ATag < CommonTag
  def initialize(id = "", css = "", text = "", href = "")
    super("a", id, css, text) do |x|
      href(href)
      with self yield self
    end
  end

  def href(s)
    add_attr("href", s)
  end
end
