class BodyTag < BaseTag
  include CommonBuilder
  include ScriptBuilder

  def initialize(id = "", css = "", text = "")
    super("body", id, css, text) do |x|
      with x yield x
    end
  end
end
