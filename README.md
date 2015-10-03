# chocolate

Simple web framework and template engine

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  chocolate:
    github: [your-github-name]/chocolate
```


## Usage

## Hello world

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

## Hello with template

```crystal
require "chocolate"
include chocolate
include zephyr

get "/" do
  html {
    head {
      title("Hello world")      
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
## Hello with view

```crystal
require "chocolate"
include chocolate
include zephyr

class HelloView
  def render
    html {
      head {
        title("Hello world")      
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


## Contributing

1. Fork it ( https://github.com/[your-github-name]/zephyr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [your-github-name](https://github.com/[your-github-name]) Grabli66 - creator, maintainer
