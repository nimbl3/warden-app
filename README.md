# README

Simple Rails authentication app build with Warden

## About Warden
Warden provides the authentication mechanism for Rack-based Ruby application.

To setup

1. Setup Warden in the middleware

```ruby
# Define the strategy and how to handle failed case
Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = lambda { |env| SessionsController.action(:new).call(env) }
end
```

2. Declare how the session is serialize/deserialize. Because we can pass any object to it.
```ruby
# To Serialize
Warden::Manager.serialize_into_session do |user|
  user.id
end

# To Deserialize
Warden::Manager.serialize_from_session do |id|
  User.find_by(id: id)
end
```

3. Declare strategies
```ruby
Warden::Strategies.add(:password) do
  def valid?
    params['email'] && params['password']
  end

  def authenticate!
    user = User.find_by(email: params['email'])

    if user && user.authenticate(params['password'])
      success! user
    else
      fail! 'Invalid email or password!'
    end
  end
end
```

4. Use warden inside controller!
```ruby
request.env['warden'].authenticate!
request.env['warden'].user
request.env['warden'].logout
```

## Setup and run the app

- `bundle install`
- `rails s -b 0.0.0.0`
