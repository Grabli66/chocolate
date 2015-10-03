require "http"
require "./*"
require "../zephyr/**"

class Handler < HTTP::Handler
  INSTANCE = new

  private def initialize
    @getTree = RouteTree.new
    @postTree = RouteTree.new
  end

  def call(request)
    resp = exec(request)
    resp || call_next(request)
  end

  def exec(request)
    path = request.path.not_nil!

    if request.method == "GET"
      nod,pars = @getTree.find_path(path)
      if nod
        resp = nod.val.not_nil!.call(GetRequest.new(request, pars.not_nil!))
        return resp.to_response
      end
    elsif request.method == "POST"
      nod,pars = @postTree.find_path(path)
      if nod
        resp = nod.val.not_nil!.call(PostRequest.new(request, pars.not_nil!))
        return resp.to_response
      end
    end
    nil
  end  

  # add route for get method
  def add_get(path, &block : BlockResponse)
    @getTree.add_path(path, block)
  end

  # add route for post method
  def add_post(path, &block : BlockResponse)
    @postTree.add_path(path, block)
  end
end
