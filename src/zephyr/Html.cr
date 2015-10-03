# class Array(T)
# 	def render
# 		str = [] of String
# 		self.each do |x|
# 			str << x.render
# 		end
# 		str.join("")
# 	end
# end
#
# # For easy class buld
# macro macro_init1(tp, id, css, text)
# 	{{ tp }}.new do |x|
# 		x.id({{ id }})
# 		x.add_css_class({{ css }})
# 		x.text({{ text }})
# 		add_child(x)
# 		with x yield
# 	end
# end
#
# macro macro_init2(tp, id, css)
# 	{{ tp }}.new do |x|
# 		x.id({{ id }})
# 		x.add_css_class({{ css }})
# 		add_child(x)
# 		with x yield
# 	end
# end
#
# # Builder modules
# module RootBuilder
# 	def html
# 		Html.new do |x|
# 			with x yield
# 		end
# 	end
# end
#
# module ScriptBuilder
# 	def script(src)
# 		Script.new do |x|
# 			x.src(src)
# 			add_child(x)
# 		end
# 	end
# end
#
# module CommonBuilder
# 	def header
# 		Header.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def nav
# 		Nav.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def section(id = "", css = "")
# 		Section.new do |x|
# 			x.id(id) unless id.empty?
# 			x.add_css_class(css) unless css.empty?
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def div(id = "", css = "", text = "")
# 		yield macro_init1(Div, id, css, text)
# 		#add_child(x)
# 		#x
# 	end
#
# 	def span
# 		Span.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def ul
# 		Ul.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def li
# 		Li.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def table
# 		Table.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def a
# 		A.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def i
# 		I.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def button
# 		Button.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def img
# 		Img.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def h1
# 		H1.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def h2
# 		H2.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def h3
# 		H3.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def p
# 		P.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
#
# 	def strong
# 		Strong.new do |x|
# 			add_child(x)
# 			with x yield
# 		end
# 	end
# end
#
# # Css helper
#
# class CssHelper
# 	def initialize()
# 		@classList = [] of String
# 	end
#
# 	def initialize(cs)
# 		@classList = cs.split(" ")
# 	end
#
# 	def add_class(c)
# 		cls = c.split(" ")
# 		cls.each do |x|
# 			unless @classList.includes?(x)
# 				@classList.push(x)
# 			end
# 		end
# 	end
#
# 	def remove_class(c)
# 		cls = c.split(" ")
# 		cls.each do |x|
# 			@classList.delete(x)
# 		end
# 	end
#
# 	def clear()
# 		@classList.clear
# 	end
#
# 	def to_s
# 		@classList.join(" ")
# 	end
# end
#
# # Abstract elements
# def el_render(name, text, childs, attrs = nil)
# 	if attrs.size > 0
# 		a = [] of String
# 		attrs.each do |k, v|
# 			a << %(#{k}="#{v}")
# 		end
# 		s = a.join(" ")
# 		return %(<#{name} #{s}>#{text}#{childs.render}</#{name}>)
# 	else
# 		return %(<#{name}>#{text}#{childs.render}</#{name}>)
# 	end
# end
#
# class Element
# 	@childs = [] of Element
# 	@name = ""
# 	@attrs = Hash(String,String).new
#
# 	property name
#
# 	def id(s : String)
# 		add_attr("id", s)
# 	end
#
# 	def add_child(c)
# 		@childs << c
# 	end
#
# 	def add_attr(k, v)
# 		@attrs[k] = v
# 	end
#
# 	def add_css_class(s)
# 		c = @attrs["class"]?
#
# 		if c
# 			add_attr("class", c)
# 		else
# 			ch = CssHelper.new()
# 			ch.add_class(s)
# 			add_attr("class", ch.to_s)
# 		end
#
# 	end
#
# 	def remove_css_class()
# 		c = @attrs["class"]?
# 		if c
# 			ch = CssHelper.new(c)
# 			ch.remove_class(s)
# 			add_attr("class", ch.to_s)
# 		end
# 	end
#
# 	def data(k, v)
# 		add_attr("data-#{k}", v)
# 	end
#
# 	def include_element(e)
# 		add_child(e)
# 	end
#
# 	def include_view(e)
# 		add_child(e.get_html)
# 	end
#
# 	def render
# 		el_render(@name, "", @childs, @attrs)
# 	end
# end
#
# class TextElement < Element
# 	@text = ""
#
# 	def text(s)
# 		@text = s
# 	end
#
# 	def render
# 		el_render(@name, @text, @childs, @attrs)
# 	end
# end
#
# # Elements
# class Html < Element
# 	def initialize
# 		@name = "html"
# 		with self yield self
# 	end
#
# 	def head
# 		Head.new do |x|
# 			add_child(x)
# 			with x yield x
# 		end
# 	end
#
# 	def body(id = "", css = "")
# 		macro_init2(Body, id, css)
# 	end
# end
#
# class Head < Element
# 	include ScriptBuilder
#
# 	def initialize
# 		@name = "head"
# 		with self yield self
# 	end
#
# 	def title(s)
# 		x = TextElement.new
# 		x.name = "title"
# 		x.text(s)
# 		add_child(x)
# 	end
#
# 	def link(rel, href)
# 		Link.new do |x|
# 			x.rel(rel)
# 			x.href(href)
# 			add_child(x)
# 		end
# 	end
# end
#
# class Link < Element
# 	def initialize
# 		@name = "link"
# 		with self yield self
# 	end
#
# 	def rel(s)
# 		add_attr("rel", s)
# 	end
#
# 	def href(s)
# 		add_attr("href", s)
# 	end
# end
#
# class Script < Element
# 	def initialize
# 		@name = "script"
# 		with self yield self
# 	end
#
# 	def src(s)
# 		add_attr("src", s)
# 	end
# end
#
# class Body < Element
# 	include CommonBuilder
# 	include ScriptBuilder
#
# 	def initialize
# 		@name = "body"
# 		with self yield self
# 	end
# end
#
# class Header < Element
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "header"
# 		with self yield self
# 	end
# end
#
# class Nav < Element
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "nav"
# 		with self yield self
# 	end
# end
#
# class Section < Element
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "section"
# 		with self yield self
# 	end
# end
#
# class Ul < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "ul"
# 		with self yield self
# 	end
# end
#
# class Li < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "li"
# 		with self yield self
# 	end
# end
#
# class Div < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "div"
# 		with self yield self
# 	end
# end
#
# class Span < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "span"
# 		with self yield self
# 	end
# end
#
# class H1 < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "h1"
# 		with self yield self
# 	end
# end
#
# class H2 < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "h2"
# 		with self yield self
# 	end
# end
#
# class H3 < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "h3"
# 		with self yield self
# 	end
# end
#
# class P < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "p"
# 		with self yield self
# 	end
# end
#
# class Strong < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "strong"
# 		with self yield self
# 	end
# end
#
# class Table < Element
# 	def initialize
# 		@name = "table"
# 		with self yield self
# 	end
#
# 	def tr
# 		Tr.new do |x|
# 			add_child(x)
# 			with x yield x
# 		end
# 	end
# end
#
# class Tr < Element
# 	def initialize
# 		@name = "tr"
# 		with self yield self
# 	end
#
# 	def td
# 		Td.new do |x|
# 			add_child(x)
# 			with x yield x
# 		end
# 	end
# end
#
# class Td < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "td"
# 		with self yield self
# 	end
# end
#
# class A < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "a"
# 		with self yield self
# 	end
#
# 	def href(s)
# 		add_attr("href", s)
# 	end
# end
#
# class I < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "i"
# 		with self yield self
# 	end
# end
#
# class Button < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "button"
# 		with self yield self
# 	end
#
# 	def type(s)
# 		add_attr("type", s)
# 	end
# end
#
# class Img < TextElement
# 	include CommonBuilder
#
# 	def initialize
# 		@name = "img"
# 		with self yield self
# 	end
#
# 	def src(s)
# 		add_attr("src", s)
# 	end
#
# 	def alt(s)
# 		add_attr("alt", s)
# 	end
# end
