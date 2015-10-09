# chocolate

Simple web framework and template engine

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  chocolate:
    github: Grabli66/chocolate
```


## Usage

### Hello world

```crystal
require "chocolate"
include chocolate
include zephyr

get "/" do
  "Hello, world!"
end

listen {
  post 8080
}
```

### Hello with template

```crystal
require "chocolate"
include chocolate
include zephyr

get "/" do
  html {
    head {
      title(text: "Hello world")      
    }    
    body {
      div(text: "Hello, world!")
    }
  }
end

listen {
  post 8080
}
```
### Hello with view

```crystal
require "chocolate"
include chocolate
include zephyr

class HelloView
  def render
    html {
      head {
        title(text: "Hello world")      
      }    
      body {
        div(text: "Hello, world!")
      }
    }
  end
end

get "/" do
  HelloView.new
end

listen {
  post 8080
}
```

### Handle params
```crystal
require "chocolate"
include chocolate
include zephyr

get "/registration/success" do
  html {
    body {
      div(css: "result", text: "Success")
    }
  }
end

get "/blog/:id" do |req|
  blog = Database.get_blog(req.params["id"])
  blog.to_s
end

post "/registration/singup" do |req|
  Database.save_user(req.params["email"], req.params["password"])  
  redirect("/registration/success")
end
```

### Handle static files
```crystal
require "chocolate"
include chocolate
include zephyr

listen {
  post 8080
  static_dir "./static"
}
```

### Handle errors
```crystal
require "chocolate"
include chocolate
include zephyr

error ERROR_NOT_FOUND do
  html {
    body {
      h1(text: "NOT FOUND!")
    }
  }
end

listen {
  post 8080  
}
```

### JSON response
```crystal
require "chocolate"
include chocolate
include zephyr

class User
  json_mapping({
    id => Int32,
    name => String,
    email => String
  })

  def initialize(@id, @name, @email)
  end
end

get "/user/:id" do |req|
  user = Database.get_user(req.params["id"])
  json(user)
end

listen {
  post 8080  
}
```

## Contributing

1. Fork it ( https://github.com/Grabli66/chocolate/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- Grabli66 (https://github.com/Grabli66) Grabli66 - creator, maintainer
