class CommonTag < BaseTag
  include CommonBuilder

  def initialize(@tag, id = "", css = "", text = "")
    super(@tag, id, css, text) do |x|
      with x yield x
    end
  end

  def onclick(s)
    add_attr("onclick", s)
  end
end
