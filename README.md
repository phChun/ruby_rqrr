# RubyRqrr

RubyRqrr (Ruby RQ'er) is a Ruby gem that provides a simple interface to scan images for QR codes. It uses the [Rust crate RQrr] (https://docs.rs/crate/rqrr/latest) under the hood to decode QR codes. This gem is a simple wrapper around the Rust crate to provide a Ruby interface.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add ruby_rqrr
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install ruby_rqrr
```

## Usage

The gem provides a module `RubyRqrr` with a single method `detect_qrs_in_image` that takes an image file path as an argument and returns an array of QR codes found in the image.

```ruby
require 'ruby_rqrr'

RubyRqrr.detect_qrs_in_image('path/to/image.png')
["https://github.com/phchun/ruby_rqrr"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/phchun/ruby_rqrr. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/phchun/ruby_rqrr/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RubyRqrr project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/phchun/ruby_rqrr/blob/main/CODE_OF_CONDUCT.md).
