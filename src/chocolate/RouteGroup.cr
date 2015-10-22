alias BlockBefore = (GetRequest | PostRequest) -> Nil

class RouteGroup
  getter before_block

  def initialize
    with self yield self
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
