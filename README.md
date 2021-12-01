# SumSub Ruby SDK

This gem is an unofficial SDK for the [SumSub API](https://developers.sumsub.com/api-reference/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sumsub-ruby-sdk', '~> 0.1.3', require: 'sumsub'
```

And then execute:

    $ bundle install

## Configuration and Usage

You can configure your credentials using `Sumsub::Configure` block. There are three keys you can inform: *token*, *secret_key* and *production*. The token and secret key you need to generate from your SumSub account, and *production* is a boolean value where you specify if you wanna use SumSub production or test environment. To use the test environment, just set production as `false`.

```ruby
Sumsub.configure do |config|
  config.token = your_token
  config.secret_key = your_secret_key
  config.production = false # is true by default
end
```

Use the `Sumsub::Request` to call the methods that access SumSub API endpoints. Check it out the [implemented methods](https://github.com/rwehresmann/sumsub-ruby-sdk/blob/master/lib/sumsub/request.rb) to know what is already available to be used.

For requests where you need to inform full objects in the request's body, `Sumsub::Struct` have some models you can use to easily fill the necessary data for the request. Check it out the models available [here](https://github.com/rwehresmann/sumsub-ruby-sdk/tree/master/lib/sumsub/struct). 

**Note:** To use `Sumsub::Struct` or not is up to you. A simple [ruby hash](https://ruby-doc.org/core-3.0.1/Hash.html) is a viable option too. Under the hood we call `to_json` to serialize it, so just ensure that this method is available and does what we expect of him: transform your object in a json string.

Usage example:

An applicant is an user that will go into the KYC process. 

- Create the applicant;
- Add an ID document to it;
- Retrieve the current applicant's status.

```ruby
request = Sumsub::Request.new

# If you didn't set your configurations on Sumsub.configure block,
# you have the option to inform it in the Request constructor, like this:
#
# request = Sumsub::Request.new(
#   token: your_token, 
#   secret_key: your_secret_key,
#   production: false
# )

applicant = Sumsub::Struct::Applicant.new(
  externalUserId: 'appt20', 
  email: 'grivia@mail.com'
)

response = request.create_applicant('basic-kyc-level', applicant)

applicant_id = response['id']

metadata = Sumsub::Struct::DocumentMetadata.new(
  idDocType: 'ID_CARD',
  country: 'BRA'
)

request.add_id_doc(
  applicant_id, 
  metadata,
  file_path: 'home/myself/Pictures/id_card.png'
)

request.get_applicant_status(applicant_id)
```

The return from `Sumsub::Request` method will always be a ruby hash (in case of success) or an instance of `Sumsub::Struct::ErrorResponse` (in case error).

## Development

Run `bin/setup` to install dependencies. For an interactive prompt that will allow you to experiment, run `bin/console`.

Run `bundle exec rspec`, if none error appears you're ready to go.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
