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

Need latest crystal compiler to compile some samples.

### Hello world

```crystal
require "chocolate"

include Zephyr
include Chocolate

get "/" do
  "Hello, world!"
end

listen {
  port 8080
}
```

### Hello with template

```crystal
require "chocolate"

include Zephyr
include Chocolate

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
  port 8080
}
```
### Hello with view

```crystal
require "chocolate"

include Zephyr
include Chocolate

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
  port 8080
}
```

### Handle params
```crystal
require "chocolate"

include Zephyr
include Chocolate

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
  port 8080
  static_dir "./static"
}
```

### Handle errors
```crystal
require "chocolate"

include Zephyr
include Chocolate

error ERROR_NOT_FOUND do
  html {
    body {
      h1(text: "NOT FOUND!")
    }
  }
end

listen {
  port 8080  
}
```

### JSON response
```crystal
require "json"
require "chocolate"

include Zephyr
include Chocolate

class Database
  def self.get_user(id)
    User.new(1, "John", "Doe")
  end
end

class User
  JSON.mapping({
    id: Int32,
    name: String,
    email: String
  })

  def initialize(@id, @name, @email)
  end
end

get "/user/:id" do |req|
  user = Database.get_user(req.params["id"] as String)
  json(user)
end

listen {
  port 8080
}
```

### View inheritance

```crystal
require "chocolate"

include Zephyr
include Chocolate

abstract class RootView < View
  abstract def render_content

  def render
    html {
      head {
        title(text: @title)
      }
      body {
        header {
          ul(css: "menu") {
            li(text: "Home") {
              css_add("active") if @location == :home
            }
            li(text: "Blog") {
              css_add("active") if @location == :blog
            }
          }
        }

        include_element(render_content)
      }
    }
  end
end

class HomeView < RootView
  def initialize
    @title = "Home"
    @location = :home
  end

  def render_content
    div(css: "home") {
      h1(text: "HOME")
    }
  end
end

class BlogView < RootView
  def initialize
    @title = "Blog"
    @location = :blog
  end

  def render_content
    div(css: "blog") {
      h1(text: "Blog")
    }
  end
end

get "/" do
  HomeView.new
end

get "/blog" do
  BlogView.new
end

listen {
  port 8080
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
