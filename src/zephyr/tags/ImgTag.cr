require "./*"

class ImgTag < CommonTag
  def initialize(id = "", css = "", src = "", alt = "")
    super("img", id, css) do |x|
      src(src)
      alt(alt)
      with self yield self
    end
  end

  def src(s)
    add_attr("src", s)
  end

  def alt(s)
    add_attr("alt", s)
  end
end
