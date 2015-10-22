class Request
  getter path
  getter version
  getter params
  getter cookies
  getter content_type

  def initialize(request : HTTP::Request)
    @path = request.path.not_nil!
    @query = request.query
    @version = request.version
    @headers = request.headers
    @cookies = {} of String => String
    @content_type = request.headers["Content-type"]? || ""
    @params = Hash(String, String).new
  end

  def initialize(request : HTTP::Request, params)
    initialize(request)
    @params = params
  end

  # Adds parameters from param string
  def add_params_from_string(params_string)
    params = params_string.split("&")
    return if params.size < 1
    params.each do |x|
      par = x.split("=")
      next if par.size < 2
      key = URI.unescape(par[0])
      val = URI.unescape(par[1])
      @params[key] = val
    end
  end
end

class GetRequest < Request
  def initialize(request : HTTP::Request, params)
    super(request, params)
    parse_get();
  end

  def parse_get()
    return unless @query
    add_params_from_string(@query.not_nil!)
  end
end

class PostRequest < Request
  getter body

  def initialize(request : HTTP::Request, params)
    super(request, params)
    @body = request.body.to_s
    parse_post()
  end

  def parse_post()
    add_params_from_string(@body)
  end
end
