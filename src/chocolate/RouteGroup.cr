alias BlockBefore = (GetRequest | PostRequest) -> Nil

class RouteGroup
  def initialize
    @before_block = nil
    with self yield self
  end

  def before_call(req)
    if @before_block
      @before_block.not_nil!.call(req)
    end
  end

  def before(&block : BlockBefore)
    @before_block = block
  end

  def get(path, &block : BlockResponse)
    Handler::INSTANCE.add_get_group(self, path, &block)
  end

  def post(path, &block : BlockResponse)
    Handler::INSTANCE.add_post_group(self, path, &block)
  end
end
