# NortonAntiVirus
Extends your [MongoMapper][] and [DataMapper][] models with filtering for creating, updating, and showing your lovely data. Helps protect against the most sofisticated internet organized crime.

## Installation
Add this line to your application's Gemfile:

    gem 'NortonAntiVirus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install NortonAntiVirus

## Usage
### In your models...

    require 'NortonAntiVirus'

    class User
      include DataMapper::Resource
      include NortonAntiVirus

      PUBLIC_CREATEABLE_KEYS = :name, :email, :password
      PUBLIC_UPDATABLE_KEYS = :name, :email, :password
      PUBLIC_KEYS = :id, :name, :email

      property :id, Serial
      property :name, String
      property :email, String
      property :admin, Boolean
      property :password, String
      property :super_secret_data, String
    end

### In your controllers...
  
    # params is data supplied by a (malicious) user
    # params => 
    # [ :id => 20, 
    #   :name => "John Doe",
    #   :email => "some@email.com",
    #   :password => "password123",
    #   :admin => true,
    #   :'Im-a-hacker' => true ]

    post '/new_user' do
      # Only :name, :email, and :password get passed into our model's create method
      user = User.create_from_public_hash(params)

      # Only data we want to expose publicly will appear: :id, :name, :email
      user.to_public_json
      # => "{\"id\":\"1\",\"name\":\"John Doe\",\"email\":\"some@email.com\"}"
    end

### Requirements
Whatever model you do choose to protect, ensure it supports the following methods:

* `::create`
* `.save`
* `.update_attributes`
* `.<attr>=`
* `.to_json`

## Availible Methods
* `Model.create_from_public_json(json_params)`
* `Model.create_from_public(hashed_params)`
* `Model.update_properties_from_public_json(json_params)`
* `Model.update_properties_from_public_hash(hashed_params)`
* `Model.to_public_json`
* `Model.to_public_hash`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[MongoMapper]: http://mongomapper.com/
[DataMapper]: http://datamapper.org/
