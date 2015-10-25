class ResourceNotFoundException < Exception
end

class ExceptionItem
  getter block

  def initialize(&@block : ExceptionBlockResponse)
  end
end

class ExceptionHandler
  INSTANCE = new

  @handlers = Hash(String, ExceptionItem).new

  def process_exception(request, exception)
    handler = @handlers[exception.class.to_s]?

    if handler
      return handler.not_nil!.block.call
    end

    # handles internal error exception
    handler = @handlers["Exception"]?
    if handler
      return handler.not_nil!.block.call
    end

    error(500)
  end

  # adds handler for specific exception
  def add_handler(exception_type, &block : ExceptionBlockResponse)
    @handlers[exception_type.to_s] = ExceptionItem.new(&block)
  end
end
