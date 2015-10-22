require "http"

# process not found error
class InternalErrorHandler
  INSTANCE = new

  @handler = nil

  def process(request)
    if @handler
      return resp = @handler.not_nil!.call(Request.new(request)).to_response
    end
    error(500)
  end

  def add_handler(&block : BlockResponse)
    @handler = block
  end
end
