require "./*"
require "../zephyr/**"

alias BlockResponse = GetRequest | PostRequest -> HTTP::Response | CommonTag | View | String | Nil
alias ExceptionBlockResponse = -> HTTP::Response | CommonTag | View | String | Nil

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

struct Nil
  def to_response
    ok("")
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

  def fork_listen
    fork do
      App.new do |x|
        with x yield x
        x.start
      end
    end
  end

  # DSL for request handlers
  def get(path, &block : BlockResponse)
    Handler::INSTANCE.add_get(path, &block)
  end

  def post(path, &block : BlockResponse)
    Handler::INSTANCE.add_post(path, &block)
  end

  # creates group for route handlers
  def group
    RouteGroup.new do |x|
      with x yield x
    end
  end

  # response helpers
  def redirect(s)
    resp = HTTP::Response.new(302, "")
    resp.headers["Location"] = s
    resp
  end

  def on_not_found(&block : BlockResponse)
    NotFoundHandler::INSTANCE.add_handler(&block)
  end

  def on_internal_error(&block : BlockResponse)
    InternalErrorHandler::INSTANCE.add_handler(&block)
  end

  def on_exception(exception_type, &block : ExceptionBlockResponse)
    ExceptionHandler::INSTANCE.add_handler(exception_type, &block)
  end

  def ok(s : String, content_type=nil)
    resp = HTTP::Response.new(200, s)
    resp.headers["Content-type"] = content_type if content_type
    resp
  end

  def error(code, text = "")
    resp = HTTP::Response.new(code, text)
    resp
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
