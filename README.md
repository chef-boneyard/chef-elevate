# Chef::Elevate

A resource for elevating privileges, and a provider for sudo.

## Why?

It's useful if you have to run Chef as a non-root user. In many environments,
that means you have systems administrators who give you a list of commands
you are allowed to run, and it's quite specific. For example, you are a
middleware team and you are allowed to restart tomcat, but only tomcat. The
command you are allowed to run is:

```
$ sudo /etc/init.d/tomcat restart
```

With the elevate resource, you would write:

```
elevate "/etc/init.d/tomcat restart"
```

And viola - you would be sudoing it up like a boss.

## Caveats

If you run Chef Client manually, or with some kind of wrapper, it
may be possible to use a password protected sudoers line, and provide
the password on the CLI. For most use cases, though, you are going to
want to automate running the chef client (either at deploy time, or
what-have-you). In those cases, you will want to make sure you have
NOPASSWD applied to your sudoers line.

## Installation

Add this line to your application's Gemfile:

    gem 'chef-elevate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chef-elevate

## Usage

Works like a normal chef execute resource. It takes the user, group, and
env arguments to execute and turns them into the proper options for the
sudo command.

I leave wrapping this up in a cookbook as an exercise to the user. :)

## Testing

To test things:

```
$ bundle install
$ bundle exec rspec # unit tests
$ bundle exec kitchen test # functional tests
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
