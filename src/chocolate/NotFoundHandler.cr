require "http"

# process not found error
class NotFoundHandler < HTTP::Handler
  INSTANCE = new

  @handler = nil

  def call(request)
    exec(request) || call_next(request)
  end

  # executes after all handlers, process not found error
  def exec(request)
    if @handler
      return resp = @handler.not_nil!.call(Request.new(request)).to_response
    end
    resp = HTTP::Response.new(404, "Resource not found")
  end

  def add_handler(&block : BlockResponse)
    @handler = block
  end
end
