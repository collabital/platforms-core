# Platforms::Core
This is a Ruby library which brings together open source and (at least
initially) Microsoft platforms. There are various gems out there to
do OAuth2 authentication, REST calls, and so on. However, this brings
everything together in one easy-to-use package.

The goal is to create a minimal representation of the external data service in order to build fuller integrations.
There is no particular integration in mind, so Platforms::Core should be as generic as possible to enable
different platforms together.

## Usage

The Core gem is typically not used on its own. Instead use it in conjunction with one (or more!) platform-specific
libraries. Those should require Platforms::Core themselves.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'platforms-core'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install platforms-core
```

Once the gem is installed, from your Rails directory you will need to install the gem's migrations:

```bash
$ rake platforms_core:install:migrations
```

## Configuration

REST-based APIs require authentication to get started. Please refer to
your platform for instructions on how to do this.

The gem assumes that you have a class called `User` and a class called `Network` which might look something like the following:

```ruby
class User < ApplicationRecord

  # A User belongs to a Platforms::User
  belongs_to :platforms_user,
    class_name: "Platforms::User",
    inverse_of: :app_user

  # Ensure a User only maps to one Platforms::User
  validates :platforms_user_id, uniqueness: true
end
```
and Network:

```ruby
class Network < ApplicationRecord

  # A Network belongs to a Platforms::Network
  belongs_to :platforms_network,
    class_name: "Platforms::Network",
    inverse_of: :app_network

  # Ensure a Network only maps to one Platforms::Network
  validates :platforms_network_id, uniqueness: true
end
```

If you need the User and Network classes to be named differently,
use configurations:

```ruby
# config/initializers/platforms.rb

Platforms::Core.configure do |config|
  config.network_class = "SampleNetwork"
  config.user_class    = "SampleUser"
end
```

## Documentation

You can generate the documentation by running

```bash
$ rake yard
```

If not everything is documented, check this with:
```bash
$ yard stats --list-undoc
```


## Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md).

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
