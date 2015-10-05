require "./*"

class SelectTag < CommonTag
  def initialize(id = "", css = "", name = "", multiple = false, size = 3)
    super("select", id, css) do |x|
      multiple(multiple)
      size(size)
      name(name) unless name.empty?
      with self yield self
    end
  end

  def multiple(s)
    add_attr("multiple", s)
  end

  def size(s)
    add_attr("size", s)
  end

  def name(s)
    add_attr("name", s)
  end
end
