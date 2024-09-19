# CustomerioAPI

This is an API wrapper gem for Customer.io API.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add customerio_api

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install customerio_api

## Usage

### Client

#### V1Client

V1Client is used to retreive data for the following resources:

- Customer
- CustomerioObject
- ObjectRelationship

V1Client is initialized with an API key which is used for bearer token authentication.

```ruby
v1_client = CustomerioAPI::V1Client.new(api_key: ENV['CUSTOMERIO_API_KEY'])
```

#### V2Client

V2Client is used to perform various operations based on the type (person, object or delivery) and action (identify, add_relationships, delete, etc) that you set in the request.

V2Client is initialized with a site_id and track_api_key which is used for basic authentication.

```ruby
v2_client = CustomerioAPI::V2Client.new(site_id: ENV['SITE_ID'], track_api_key: ENV['TRACK_API_KEY'])
```

### Customer

#### 1. Get a list of customers by email

```ruby
customers = v1_client.customer.where(email: 'test@example.com')

# => returns a list of CustomerioAPI::Customer
```

#### 2. Use s set of filter conditions to find customer

```ruby
attributes =
  {
    filter: {
      and:
          [
            {
              attribute: {
                field: 'cio_id',
                operator: 'eq',
                value: 'd7a90a000a0b'
              }
            }
          ]
    }
  }
customer_identifiers = v1_client.customer.search(attributes: attributes)

# => returns a CustomerioAPI::Customer object, containing arrays of identifiers and ids
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

v1_client.object.where(attributes: attributes, start: start, limit: limit)

# => returns a CustomerioAPI::CustomerioObject
```

### ObjectRelationship

#### 1. Get a list of people related to an object.

```ruby
# query_params is optional
query_params = {start: string, limit: integer, id_type: "object_id" | "cio_object_id"}
v1_client.object_relationship.where(object_type_id: 1, object_id: 'PostCo', query_params: query_params)

# => returns a CustomerioAPI::ObjectRelationship
```

### Track

#### 1. Single request

This endpoint lets create, update, or delete a single person or object—including managing relationships between objects and people.

```ruby
# Create a person
attributes = { type: 'object', action: 'identify', identifiers: { object_type_id: '1', object_id: 'test'}, attributes: {name: "test"} }
v2_client.track.entity(attributes)

# => returns {}
```

#### 2. Multiple request

This endpoint lets you batch requests for different people and objects in a single request.

```ruby
# Update multiple objects
attributes = [
    { type: 'object', action: 'identify', identifiers: { object_type_id: '1', object_id: 'shop-1' }, attributes: { name: 'Shop 1 updated' } },
    { type: 'object', action: 'identify', identifiers: { object_type_id: '1', object_id: 'shop-2' }, attributes: { name: 'Shop 2 updated' } }
    ]
v2_client.track.batch(attributes)

# => returns {}
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
