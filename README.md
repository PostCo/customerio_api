# CustomerioAPI

This is an API wrapper gem for Customer.io API.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add customerio_api

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install customerio_api

## Usage

### Client

Customer.io API client is initialized with an API key which is used for bearer token authentication.

```ruby
client = CustomerioAPI::Client.new(api_key: ENV['CUSTOMERIO_API_KEY'])
```

### Customer

#### 1. Get a list of customers by email

```ruby
customers = client.customer.where(email: 'test@example.com')

# => returns a list of Customerio::Customer
```

### CustomerioObject

#### 1. Use a set of filter conditions to find object

```ruby
attributes =
{
    "object_type_id": '1',
    "filter": {
    "and":
        [
            {
            "object_attribute": {
                "field": 'name',
                "operator": 'eq',
                "type_id": '1',
                "value": 'PostCo'
            }
            }
        ]
    }
}

# start and limit params are optional
start = "0"
limit = 10

client.object.where(attributes: attributes, start: start, limit: limit)

# => returns a Customerio::CustomerioObject
```

### ObjectRelationship

#### 1. Get a list of people related to an object.

```ruby
# query_params is optional
query_params = {start: string, limit: integer, id_type: "object_id" | "cio_object_id"}
client.object_relationship.where(object_type_id: 1, object_id: 'PostCo', query_params: query_params)

# => returns a Customerio::ObjectRelationship
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/customerio_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/customerio_api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CustomerioAPI project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/customerio_api/blob/master/CODE_OF_CONDUCT.md).
