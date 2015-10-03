module CommonBuilder
  def header(id = "", css = "")
    CommonTag.new("header", id, css) do |x|
      add_child(x)
      with x yield x
    end
  end

  def header(id = "", css = "")
    header(id, css) {}
  end

  def footer(id = "", css = "")
    CommonTag.new("footer", id, css) do |x|
      add_child(x)
      with x yield x
    end
  end

  def footer(id = "", css = "")
    footer(id, css) {}
  end

  def nav(id = "", css = "")
    CommonTag.new("nav", id, css) do |x|
      add_child(x)
      with x yield x
    end
  end

  def nav(id = "", css = "")
    nav(id, css) {}
  end

  def section(id = "", css = "")
    CommonTag.new("section", id, css) do |x|
      add_child(x)
      with x yield x
    end
  end

  def section(id = "", css = "")
    section(id, css) {}
  end

  def h1(id = "", css = "", text = "")
    CommonTag.new("h1", id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def h1(id = "", css = "", text = "")
    h1(id, css, text) {}
  end

  def h2(id = "", css = "", text = "")
    CommonTag.new("h2", id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def h2(id = "", css = "", text = "")
    h2(id, css, text) {}
  end

  def h3(id = "", css = "", text = "")
    CommonTag.new("h3", id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def h3(id = "", css = "", text = "")
    h3(id, css, text) {}
  end

  def h4(id = "", css = "", text = "")
    CommonTag.new("h4", id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def h4(id = "", css = "", text = "")
    h4(id, css, text) {}
  end

  def p(id = "", css = "", text = "")
    CommonTag.new("p", id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def p(id = "", css = "", text = "")
    p(id, css, text) {}
  end

  def i(id = "", css = "", text = "")
    CommonTag.new("i", id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def i(id = "", css = "", text = "")
    i(id, css, text) {}
  end

  def div(id = "", css = "", text = "")
    CommonTag.new("div", id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def div(id = "", css = "", text = "")
    div(id, css, text) {}
  end

  def span(id = "", css = "", text = "")
    CommonTag.new("span", id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def span(id = "", css = "", text = "")
    span(id, css, text) {}
  end

  def strong(id = "", css = "", text = "")
    CommonTag.new("strong", id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def strong(id = "", css = "", text = "")
    strong(id, css, text) {}
  end

  def ul(id = "", css = "")
    CommonTag.new("ul", id, css) do |x|
      add_child(x)
      with x yield x
    end
  end

  def ul(id = "", css = "")
    ul(id, css) {}
  end

  def li(id = "", css = "", text = "")
    CommonTag.new("li", id, css, text) do |x|
      add_child(x)
      with x yield x
    end
  end

  def li(id = "", css = "", text = "")
    li(id, css, text) {}
  end

  def table(id = "", css = "")
    CommonTag.new("table") do |x|
      add_child(x)
      with x yield x
    end
  end

  def table(id = "", css = "")
    table(id, css) {}
  end

  def tr(id = "", css = "")
    CommonTag.new("tr") do |x|
      add_child(x)
      with x yield x
    end
  end

  def tr(id = "", css = "")
    tr(id, css) {}
  end

  def td(id = "", css = "")
    CommonTag.new("td") do |x|
      add_child(x)
      with x yield x
    end
  end

  def td(id = "", css = "")
    td(id, css) {}
  end

  def button(id = "", css = "", text = "", type = "")
    ButtonTag.new(id, css, text, type) do |x|
      add_child(x)
      with x yield x
    end
  end

  def button(id = "", css = "", text = "", type = "")
    button(id, css, text, type) {}
  end

  def a(id = "", css = "", text = "", href = "")
    ATag.new(id, css, text, href) do |x|
      add_child(x)
      with x yield x
    end
  end

  def a(id = "", css = "", text = "", href = "")
    a(id, css, text, href) {}
  end

  def img(id = "", css = "", src = "", alt = "")
    ImgTag.new(id, css, src, alt) do |x|
      add_child(x)
      with x yield x
    end
  end

  def img(id = "", css = "", src = "", alt = "")
    img(id, css, src, alt) {}
  end

  def form(id = "", css = "", action = "", method = "")
    FormTag.new(id, css, action, method) do |x|
      add_child(x)
      with x yield x
    end
  end

  def form(id = "", css = "", action = "", method = "")
    form(id, css, action, method) {}
  end

  def label(id = "", css = "", for = "")
    LabelTag.new(id, css, for) do |x|
      add_child(x)
      with x yield x
    end
  end

  def label(id = "", css = "", for = "")
    label(id, css, for) {}
  end

  def input(id = "", css = "", type = "", placeholder = "", required = false, name = "")
    InputTag.new(id, css, type, placeholder, required, name) do |x|
      add_child(x)
      with x yield x
    end
  end

  def input(id = "", css = "", type = "", placeholder = "", required = false, name = "")
    input(id, css, type, placeholder, required, name) {}
  end

  def textarea(id = "", css = "", rows = "", placeholder = "", required = false)
    TextAreaTag.new(id, css, rows, placeholder, required) do |x|
      add_child(x)
      with x yield x
    end
  end

  def textarea(id = "", css = "", rows = "", placeholder = "", required = false)
    textarea(id, css, rows, placeholder, required) {}
  end
end
