class App
  @port = 8080

  def initialize
    with self yield self
  end

  def port(@port)
  end

  def static_dir(@static_dir)
  end

  def start
    handlers = [] of HTTP::Handler
    handlers << Handler::INSTANCE
    handlers << HTTP::StaticFileHandler.new(@static_dir.not_nil!) if @static_dir
    server = HTTP::Server.new(@port, handlers)
    puts "Chocolate server is running"
    server.listen()
  end
end
