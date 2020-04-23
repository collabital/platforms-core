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

Once the gem is installed, from your Rails directory you will can run the following generator to complete the installation:

```bash
$ rails generate platforms:core:install
```

This will:

* Copy a basic initializer to `config/initializers/platforms_core.rb`; and
* Install the gem's migrations into your application.

## Configuration

REST-based APIs require authentication to get started. Please refer to
your platform for instructions on how to do this.

### Starting a New App

Your application needs to have at least `Network` and `User` models. These can be created by calling the generator:

```bash
$ rails generate platform:core:network foo some_info:string
$ rails generate platform:core:user bar user more_info:string
```

Most of the options for the regular ActiveRecord model generator are available, including namespacing and indexing.

This is roughly equivalent to calling the standard Rails model generators (`rails g model foo some_info:string`), however by using the above version the resulting models are configured by Platforms::Core as the `Network` or `User` models.

Typically these would be called "Network" and "User", but here we have called them "Foo" and "Bar".

### Adding to an Existing App

If you already have `Network` and `User` models (which let's assume are called "Foo" and "Bar" respectively), you can add the relevant configuration by using the generator with the `--existing-model` flag:

```bash
$ rails generate platform:core:network foo --existing-model
$ rails generate platform:core:user bar --existing-model
```

This will add the relevant concerns to the models, and update the initializer, without needing to create models from scratch.

### Manual Configuration

Finally, if you don't want to use the built-in generators then you can always create the models and configuration manually. The models should look something like this for a `Network`:

```ruby
# app/models/network.rb

class Network < ApplicationRecord
  include Platforms::Core::AppNetwork

  # This requires an integer database column called
  # 'platforms_network_id'

  # ...
end
```

and for a `User`:

```ruby
# app/models/user.rb

class User < ApplicationRecord
  include Platforms::Core::AppUser

  # This requires an integer database column called
  # 'platforms_user_id'

  # ...
end
```

Additionally, you will need to create an initializer which configures the `Network` and `User` classes for the gem:

```ruby
# config/initializers/platforms.rb

Platforms::Core.configure do |config|
  config.network_class = "Foo"
  config.user_class    = "Bar"
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
