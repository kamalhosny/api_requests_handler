# HttpClient

A simple HTTP client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'http_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install http_client

## Usage

you can use the gem by starting a request :

```ruby
HttpClient::Request.new(method:, app:, retry_count:, data:, headers:, &success_block)
```
and you should pass the arguments as shown in the options section.

### Options

| option        | Description | Default |
|---------------|-------------|---------|
| method        | Http request method | ```:get``` |
| app           | This attribute is responsible for getting all the corresponding info related to the application you are sending a request to, add the application info to .env file and prefix them with the name; e.g., 'APPNAME_URL'. |
| retry_count   | The number of retries incase of failure. | ```0``` |
| data          | This should be the query data when method is ```:get``` or the data you are sending when method is ```:post, :put or :patch```. | ```{}``` |
| headers       | This contains the headers of your request | ```{}``` |
| success_block | This will be executed when the response status is success |

### Configuration

in your ```.env``` file add your applications info with replacing the ```APPNAME``` and the values :

```
APPNAME_APP_ID=12345678
APPNAME_TOKEN=123lASDASD12324
APPNAME_URL=https://jsonplaceholder.typicode.com/posts
```
## Example

After installing the Gem 
put in your rails application wherever you want to use it:
```ruby
HttpClient::Request.new(
                  method: :get,  
                  app: :example_app, 
                  retry_count: 5, 
                  headers: { 'Content-Type': 'application/json' }
                )
```
create a ```.env``` file and put your application info on it : 
```
EXAMPLE_APP_URL=https://jsonplaceholder.typicode.com/posts
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kamalhosny/http_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

