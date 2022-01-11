# frozen_string_literal: true

module Sumsub
  # https://developers.sumsub.com/api-reference/#verifying-webhook-sender
  class WebhookSender
    def self.get_payload(params)
      JSON.pretty_generate(
        params,
        space_before: ' ',
      )
      .gsub("[\n      \"", "[ \"")
      .gsub("\n    ]", " ]")
    end
  end
end
