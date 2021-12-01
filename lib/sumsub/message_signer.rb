# frozen_string_literal: true

module Sumsub
  # https://developers.sumsub.com/api-reference/#signing-a-request
  class MessageSigner
    def self.sign(
      time:, 
      resource:, 
      method:, 
      body: nil, 
      secret_key: Sumsub.configuration.secret_key
    )
      data = time.to_s + method + '/resources/' + resource + body.to_s
      digest = OpenSSL::Digest.new('sha256')

      OpenSSL::HMAC.hexdigest(digest, secret_key, data)
    end
  end
end
