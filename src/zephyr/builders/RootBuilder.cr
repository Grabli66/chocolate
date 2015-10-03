module RootBuilder
  def html
    HtmlTag.new do |x|
      add_child(x)
      with x yield x
    end
  end
end
