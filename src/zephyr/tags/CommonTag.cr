class CommonTag < BaseTag
  include CommonBuilder

  def initialize(@tag, id = "", css = "", text = "")
    super(@tag, id, css, text) do |x|
      with x yield x
    end
  end
end
