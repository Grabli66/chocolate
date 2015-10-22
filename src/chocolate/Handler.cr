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
    begin
      resp = exec(request)
    rescue e
      return ExceptionHandler::INSTANCE.process_exception(request, e).to_response
    end
    resp || call_next(request)
  end

  # process request
  def exec(request)
    path = request.path.not_nil!

    if request.method == "GET"
      nod,pars = @getTree.find_path(path)
      if nod
        req = GetRequest.new(request, pars.not_nil!)
        if nod.group
          nod.group.not_nil!.before_block.not_nil!.call(req)
        end
        resp = nod.val.not_nil!.call(req)
        return resp.to_response
      end
    elsif request.method == "POST"
      nod,pars = @postTree.find_path(path)
      if nod
        req = PostRequest.new(request, pars.not_nil!)
        if nod.group
          nod.group.not_nil!.before_block.not_nil!.call(req)
        end
        resp = nod.val.not_nil!.call(req)
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

  # add route for get method, for group
  def add_get_group(group, path, &block : BlockResponse)
    @getTree.add_path(path, block, group)
  end
end
