require "http"

# process not found error
class NotFoundHandler < HTTP::Handler
  INSTANCE = new

  def initialize
    ExceptionHandler::INSTANCE.add_handler(ResourceNotFoundException) {
      error(404)
    }
  end

  def call(request)
    exec(request) || call_next(request)
  end

  # executes after all handlers, process not found error
  def exec(request)
    raise ResourceNotFoundException.new
  end
end
