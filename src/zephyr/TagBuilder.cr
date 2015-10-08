class Array(T)
	def render
		str = [] of String
		self.each do |x|
			str << x.render
		end
		str.join("")
	end
end

module CommonBuilder
  def add_child(s)
  end
end

class CommonTag
  include CommonBuilder

  def initialize(@tag, id="",css="",text="")
    @childs = Array(CommonTag).new
    @attrs = Hash(String,(String | Bool | Int32)).new
		id(id) unless id.empty?
		css_add(css) unless css.empty?
    text(text) unless text.empty?
  end

  def id(s : String)
		add_attr("id", s)
  end

  def text(s)
    @text = s
  end

	def onclick(s : String)
    add_attr("onclick", s)
  end

  def add_child(s)
    @childs.push(s)
  end

  def add_attr(k, v)
		if v.is_a?(String)
			@attrs[k] = v unless v.empty?
		else
			@attrs[k] = v
		end
	end

  def css_add(s)
		c = @attrs["class"]?

		if c
			add_attr("class", c)
		else
			ch = CssHelper.new()
			ch.add_class(s)
			add_attr("class", ch.to_s)
		end
	end

	def css_remove()
		c = @attrs["class"]?
		if c
			ch = CssHelper.new(c)
			ch.remove_class(s)
			add_attr("class", ch.to_s)
		end
	end

  def data(k, v)
		add_attr("data-#{k}", v)
	end

	def include_element(e)
		add_child(e)
	end

	def include_view(e)
		add_child(e.render)
	end

	def render
  	if @attrs.size > 0
  		a = [] of String
  		@attrs.each do |k, v|
  			a << %(#{k}="#{v}")
  		end
  		s = a.join(" ")
  		return %(<#{@tag} #{s}>#{@text}#{@childs.render}</#{@tag}>)
  	else
  		return %(<#{@tag}>#{@text}#{@childs.render}</#{@tag}>)
  	end
	end
end

macro tag(name, *params)
  {% names = params.map {|param| param.is_a?(Assign) ? param.target : param } %}
  module CommonBuilder
    def {{name.stringify.downcase.id}}(id="",css="",text="", {{params.argify}})
      {{name.stringify.capitalize.id}}Tag.new(id, css, text, {{names.argify}}) do |instance|
        add_child(instance)
        with instance yield instance
      end
    end

    def {{name.stringify.downcase.id}}(id="",css="",text="",{{params.argify}})
      {{name.stringify.downcase.id}}(id,css,text,{{names.argify}}) {}
    end
  end

  class {{name.stringify.capitalize.id}}Tag < CommonTag
    def initialize(id, css, text, {{params.argify}})
      super({{name.stringify.downcase}}, id, css, text)

      {% for param in names %}
      	add_attr({{param.stringify}}, {{param.id}})
      {% end %}

      with self yield self
    end

    {% for param in names %}
      def {{param.id}}(value)
        add_attr({{param.stringify}}, value)
      end
    {% end %}
  end
end

tag(a,accesskey="",coords="",download="",href="",hreflang="",name="",rel="",rev="",shape="",tabindex="",target="",title="",type="")
tag(abbr,title="")
tag(acronim)
tag(address)
tag(applet,align="",alt="",archive="",code="",codebase="",height="",hspace="",vspace="",width="")
tag(area,alt="",coords="",href="",hreflang="",nohref="",shape="",tabindex="",target="",type="")
tag(article)
tag(aside)
tag(audio,autoplay="",controls="",loop="",preload="",src="")
tag(b)
tag(base,href="",target="")
tag(basefont,color="",face="",size="")
tag(bdi)
tag(bdo,dir="")
tag(bgsound,balance="",loop="",src="",volume="")
tag(big)
tag(blink)
tag(blockquote)
tag(body,alink="",background="",bgcolor="",bgproperties="",bottommargin="",leftmargin="",link="",rightmargin="",scroll="",color="",topmargin="",vlink="")
tag(br,clear="")
tag(button,accesskey="",autofocus="",disabled="",form="",formaction="",formenctype="",formmethod="",formnovalidate="",formtarget="",name="",type="",value="")
tag(canvas,height="",width="")
tag(caption,align="",valign="")
tag(center)
tag(cite)
tag(code)
tag(col,align="",char="",charoff="",span="",valign="",width="")
tag(colgroup,align="",char="",charoff="",span="",valign="",width="")
tag(command,checked="",disabled="",icon="",label="",radiogroup="",type="")
tag(comment)
tag(datalist)
tag(dd)
tag(del,cite="",datetime="")
tag(details,open="")
tag(dfn)
tag(dir)
tag(div,align="",title="")
tag(dl)
tag(dt)
tag(em)
tag(embed,align="",height="",hidden="",hspace="",pluginspage="",src="",type="",vspace="",width="")
tag(fieldset,disabled="",form="",title="")
tag(figcaption)
tag(figure)
tag(font,color="",face="",size="")
tag(footer)
tag(form, accept_charset="",action="",autocomplete="",enctype="",method="",name="",novalidate="",target="")
tag(frame,bordercolor="",frameborder="",name="",noresize="",scrolling="",src="")
tag(frameset,border="",bordercolor="",cols="",frameborder="",framespacing="",rows="")
tag(h1,align="")
tag(h2,align="")
tag(h3,align="")
tag(h4,align="")
tag(h5,align="")
tag(h6,align="")
tag(head,profile="")
tag(header)
tag(hgroup)
tag(hr,align="",color="",noshade="",size="",width="")
tag(html,title="",manifest="",xmlns="")
tag(i)
tag(iframe,align="",allowtransparency="",frameborder="",height="",hspace="",marginheight="",marginwidth="",name="",sandbox="",scrolling="",seamless="",src="",srcdoc="",vspace="",width="")
tag(img,align="",alt="",border="",height="",hspace="",ismap="",longdesc="",lowsrc="",src="",vspace="",width="",usemap="")
tag(input,accept="",accesskey="",align="",alt="",autocomplete="",autofocus="",border="",checked="",
		disabled="",form="",formaction="",formenctype="",formmethod="",formnovalidate="",formtarget="",
		list="",max="",maxlength="",min="",multiple="",name="",pattern="",placeholder="",readonly="",
		required=true,size="",src="",step="",tabindex="",type="",value="")
tag(ins,cite="",datetime="")
tag(isindex,action="",prompt="")
tag(kbd)
tag(keygen,autofocus="",challenge="",disabled="",form="",keytype="",name="")
tag(label,accesskey="",for="")
tag(legend,accesskey="",align="",title="")
tag(li,type="",value="")
tag(link,charset="",href="",media="",rel="",sizes="",type="")
tag(listing)
tag(main)
tag(map,name="")
tag(mark)
tag(marquee,behavior="",bgcolor="",direction="",height="",hspace="",loop="",scrollamount="",scrolldelay="",truespeed="",vspace="",width="")
tag(menu,label="",type="")
tag(meta,charset="",content="",http_equiv="",name="")
tag(meter,value="",min="",max="",low="",high="",optimum="")
tag(multicol,cols="",gutter="",width="")
tag(nav)
tag(nobr)
tag(noembed)
tag(noframes)
tag(noscript)
tag(object,align="",archive="",classid="",code="",codebase="",codetype="",data="",height="",hspace="",tabindex="",type="",vspace="",width="")
tag(ol,type="",reversed="",start="")
tag(optgroup,disabled="",label="")
tag(option,disabled="",label="",selected="",value="")
tag(output,for="",form="",name="")
tag(p,align="")
tag(param,name="",type="",value="",valuetype="")
tag(plaintext)
tag(pre)
tag(progress,value="",max="")
tag(q,cite="")
tag(rp)
tag(rt)
tag(ruby)
tag(s)
tag(samp)
tag(script,async="",defer="",language="",src="",type="")
tag(section)
tag(select,accesskey="",autofocus="",disabled="",form="",multiple="",name="",required=true,size="",tabindex="")
tag(small)
tag(source,media="",src="",type="")
tag(spacer,align="",height="",size="",type="",width="")
tag(span)
tag(strike)
tag(strong)
tag(style,media="",type="")
tag(sub)
tag(summary)
tag(sup)
tag(table,align="",background="",bgcolor="",border="",bordercolor="",cellpadding="",cellspacing="",cols="",frame="",height="",rules="",summary="",width="")
tag(tbody,align="",char="",charoff="",bgcolor="",valign="")
tag(td,abbr="",align="",axis="",background="",bgcolor="",bordercolor="",char="",charoff="",colspan="",headers="",height="",nowrap="",rowspan="",scope="",valign="",width="")
tag(textarea,accesskey="",autofocus="",cols="",disabled="",form="",maxlength="",name="",placeholder="",readonly="",required=true,rows="",tabindex="",wrap="")
tag(tfoot,align="",bgcolor="",char="",charoff="",valign="")
tag(th,abbr="",align="",axis="",background="",bgcolor="",bordercolor="",char="",charoff="",colspan="",headers="",height="",nowrap="",rowspan="",scope="",valign="",width="")
tag(thead,align="",char="",charoff="",bgcolor="",valign="")
tag(time,datetime="",pubdate="")
tag(title)
tag(tr,align="",bgcolor="",bordercolor="",char="",charoff="",valign="")
tag(track,kind="",src="",srclang="",label="",default="")
tag(tt)
tag(u)
tag(ul,type="")
tag(var)
tag(video,autoplay="",controls="",height="",loop="",poster="",preload="",src="",width="")
tag(wbr)
tag(xmp)
