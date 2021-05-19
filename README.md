# SumSub Ruby SDK

This gem is an unnoficial SDK for the [SumSub API](https://developers.sumsub.com/api-reference/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sumsub-ruby-sdk', git: 'https://github.com/rwehresmann/sumsub-ruby-sdk'
```

And then execute:

    $ bundle install

## Usage

Use the `Sumsub::Request` to call the methods that access SumSub API endpoints. Check it out the [implemented methods](https://github.com/rwehresmann/sumsub-ruby-sdk/blob/master/lib/sumsub/request.rb) to know what is already available to be used.

For requests where you need to inform full objects in the request's body, `Sumsub::Struct` have some models you can use to easily fill the necessary data for the request. Check it out the models available [here](https://github.com/rwehresmann/sumsub-ruby-sdk/tree/master/lib/sumsub/struct). 

**Note:** To use `Sumsub::Struct` or not is up to you. A simple [ruby hash](https://ruby-doc.org/core-3.0.1/Hash.html) is a viable option too. Under the hood we call `to_json` to serialize it.

Usage example:

An applicant is a user that will go into the KYC process. 

- Create the applicant;
- Add an ID document to it;
- Retrieve the current applicant's status.

```ruby
request = Sumsub::Request.new(your_token, your_secret_key)

applicant = Sumsub::Struct::Applicant.new(
  externalUserId: 'appt20', 
  email: 'grivia@mail.com'
)

response = request.create_applicant('basic-kyc-level', applicant)

applicant_id = JSON.parse(response.to_s)['id']

metadata = Sumsub::Struct::DocumentMetadata.new(
  idDocType: 'ID_CARD',
  country: 'BRA'
)

request.add_id_doc(
  applicant_id, 
  metadata,
  file_name: 'home/myself/Pictures/id_card.png'
)

request.get_applicant_status(applicant_id)
```

## Development

Run `bin/setup` to install dependencies. For an interactive prompt that will allow you to experiment, run `bin/console`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
