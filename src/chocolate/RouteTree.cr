class RouteNode
  @key = ""
  @components = [] of String

  getter key
  property val
  property components
  getter childs

  def initialize(@key, @val)
    @childs = Hash(String, RouteNode).new
  end

  def add_node(k , v)
    n = @childs[k]?
    return n if n

    n = RouteNode.new(k, v)
    @childs[k] = n
    n
  end

  def get_node(k)
    @childs[k]?
  end

  def add_path(path, val)
    if path == "/"
      pa = ["/"]
    else
      pa = path.split("/")
    end
    c = [] of String

    nod = self
    pa.each do |x|
      s = x
      if s.starts_with?(":")
        s = "*"
      end
      c << x
      nod = nod.add_node(s, nil)
    end
    nod.val = val
    nod.components = c
  end

  def find_path(path)
    if path == "/"
      pa = ["/"]
    else
      pa = path.split("/")
    end
    nod = self
    pa.each do |x|
      nd = nod.childs["*"]?
      nod = nd ? nd : nod.childs[x]?
      return nil,nil unless nod
      nod = nod.not_nil!
    end
    return nod, nod.get_params(pa)
  end

  def get_params(comps)
    params = nil
    @components.zip(comps) do |route_component, req_component|
      if route_component.starts_with? ':'
        params ||= {} of String => String
        params[route_component[1 .. -1]] = req_component
      else
        return nil unless route_component == req_component
      end
    end

    params ||= {} of String => String
    params
  end
end

class RouteTree < RouteNode
  def initialize
    super("", nil)
  end
end
