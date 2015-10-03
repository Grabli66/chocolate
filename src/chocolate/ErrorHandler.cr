require "http"

ERROR_NOT_FOUND = 404

class HttpError
  getter handler

  def initialize(@code, &@handler : BlockResponse)
  end
end


class ErrorHandler < HTTP::Handler
  INSTANCE = new

  @errors = Hash(Int32, HttpError).new

  def call(request)
    exec(request) || call_next(request)
  end

  def exec(request)
    er = @errors[ERROR_NOT_FOUND]?
    return resp = er.not_nil!.handler.call(Request.new(request)).to_response if er
    resp = HTTP::Response.new(ERROR_NOT_FOUND, "Resource not found")    
  end

  def add_error(code, &block : BlockResponse)
    @errors[code] = HttpError.new(code, &block)
  end
end
