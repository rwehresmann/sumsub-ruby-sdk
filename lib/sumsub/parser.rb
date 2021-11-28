# frozen_string_literal: true

module Sumsub
  class Parser
    def self.parse(json_payload)
      payload = JSON.parse(json_payload)

      # return unless is an error response
      return payload unless (payload['code'] && payload['description'])

      Sumsub::Struct::ErrorResponse.new(
        description: payload['description'],
        code: payload['code'],
        correlation_id: payload['correlationId'],
        error_code: payload['errorCode'],
        error_name: payload['errorName']
      )
    end
  end
end
