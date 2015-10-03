require "./*"
require "../zephyr/**"

alias BlockResponse = GetRequest | PostRequest -> HTTP::Response | BaseTag | View | String

class BaseTag
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
end
