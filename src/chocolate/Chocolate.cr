require "./*"
require "../zephyr/**"

alias BlockResponse = GetRequest | PostRequest -> HTTP::Response | CommonTag | View | String

class CommonTag
  def to_response
    ok(render)
  end
end

class View
  def to_response
    ok(get_html)
  end
end

class String
  def to_response
    ok(self)
  end
end

class HTTP::Response
  def to_response
    self
  end
end

module Chocolate
  extend self

  # helper for app create
  def listen
    App.new do |x|
      with x yield x
      x.start
    end
  end

  # DSL for request handlers
  def get(path, &block : BlockResponse)
    Handler::INSTANCE.add_get(path, &block)
  end

  def post(path, &block : BlockResponse)
    Handler::INSTANCE.add_post(path, &block)
  end

  def redirect(s)
    resp = HTTP::Response.new(302, "")
    resp.headers["Location"] = s
    resp
  end

  def error(code, &block : BlockResponse)
    ErrorHandler::INSTANCE.add_error(code, &block)
  end

  def ok(s : String)
    HTTP::Response.new(200, s)
  end

  def json(obj)
    s = ""
    if obj.is_a?(String)
      s = obj
    elsif obj.responds_to?(:to_json)
      s = obj.to_json
    end

    resp = HTTP::Response.new(200, s)
    resp.headers["Content-type"] = "application/json; charset=utf-8"
    resp
  end
end
