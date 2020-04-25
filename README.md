# Platforms::Core

This is a Ruby library which brings together open source and (at least
initially) Microsoft platforms. There are various gems out there to
do OAuth2 authentication, REST calls, and so on. However, this brings
everything together in one easy-to-use package.

The goal is to create a minimal representation of the external data service in order to build fuller integrations.
There is no particular integration in mind, so Platforms::Core should be as generic as possible to enable a variety of different integration types.

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

Once the gem is installed, from your Rails directory you can run the following generator to complete the installation:

```bash
$ rails generate platforms:core:install
```

This will:

* Add a basic initializer to `config/initializers/platforms_core.rb`; and
* Copy the gem's migrations into your application.

## Configuration

REST-based APIs require authentication to get started. Please refer to
your platform for instructions on how to do this.

### Starting a New App

Your application needs to have at least `Network` and `User` models. These can be created by calling the generator:

```bash
$ rails generate platforms:core:network foo some_info:string
$ rails generate platforms:core:user bar user more_info:string
$ rake db:migrate
```

Most of the options for the regular [ActiveRecord model generator](https://guides.rubyonrails.org/active_record_migrations.html#model-generators) are available, including namespacing and indexing for columns.

The above commands are roughly equivalent to calling the regular ActiveRecord model generators (`rails g model foo some_info:string`), but also configure the models in Platforms::Core as the `Network` or `User` models.

Typically these would actually be called "Network" and "User", but here we have called them "Foo" and "Bar".

### Adding to an Existing App

If you already have `Network` and `User` models (which let's assume are called "Foo" and "Bar" respectively), you can configure them for Platforms::Core by using the generator with the `--existing-model` flag:

```bash
$ rails generate platforms:core:network foo --existing-model
$ rails generate platforms:core:user bar --existing-model
$ rake db:migrate
```

This will skip the model creation, but will still:

* Create migrations for the Foo and Bar models;
* Add the relevant concerns to each models; and
* Update the `platforms_core` initializer.

Again, this accepts the standard naming convention for Rails files, so use `admin/my_foo` if you model is Admin::MyFoo.

### Manual Configuration

Finally, if you don't want to use the built-in generators then you can always create the models and configuration manually. The models should look something like this for a `Network`:

```ruby
# app/models/network.rb

class Network < ApplicationRecord
  include Platforms::Core::AppNetwork

  # This module expects an integer database column called
  # 'platforms_network_id'

  # ...
end
```

and for a `User`:

```ruby
# app/models/user.rb

class User < ApplicationRecord
  include Platforms::Core::AppUser

  # This module expects an integer database column called
  # 'platforms_user_id'

  # ...
end
```

Additionally, you will need to create an initializer which configures the `Network` and `User` classes for the gem:

```ruby
# config/initializers/platforms_core.rb

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
