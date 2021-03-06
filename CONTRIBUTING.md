# Contributing

## Quick Overview

We love pull requests. Here's a quick overview of the process (detail below):

1. Fork the repo.

2. Run the tests. We only take pull requests with passing tests, so start with a clean slate.

3. Add a test for your new code. Only refactoring and documentation changes require no new tests. If you are adding functionality or fixing a bug, we need a test!

4. Make the test pass.

5. Push to your fork and submit a pull request.

At this point you're waiting on us. We may suggest some changes or improvements or alternatives. Once we approve, we will merge your branch in.

Some things that will increase the chance that your pull request is accepted, taken straight from the Ruby on Rails guide:

* Use Rails idioms and helpers
* Include tests which fail without your code and pass with it
* Update the documentation, the surrounding code, examples elsewhere, guides, whatever is affected by your contribution


## Requirements

Please remember this is open-source, so don't commit any passwords or API keys.
Those should go in config variables like `ENV['API_KEY']`.

## Setup

Fork the repo and clone the app:

    git clone git@github.com:[GIT_USERNAME]/platforms-core.git

Install Bundler:

    gem install bundler

Set up the app (contained in `spec/dummy`):

    cd platforms-core
    bundle

## Running tests

Run the whole test suite with:

    rake

Run individual specs like:

    rspec spec/models/platforms/network_spec.rb

Tab complete to make it even faster!

## Syntax

* Two spaces, no tabs.
* No trailing whitespace. Blank lines should not have any spaces.
* Prefer `&&/||` over `and/or`.
* `MyClass.my_method(my_arg)` not `my_method( my_arg )` or `my_method my_arg`.
* `a = b` and not `a=b`.
* Follow the conventions you see used in the source already.

And in case we didn't emphasize it enough: we love tests!
