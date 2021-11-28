# frozen_string_literal: true

module Sumsub
  module Struct
    # https://developers.sumsub.com/api-reference/#response-body
    class ErrorResponse < BaseStruct
      attribute :description, Types::String.optional
      attribute :code, Types::Coercible::String.optional
      attribute :correlation_id, Types::Coercible::String.optional

      attribute? :error_code, Types::Coercible::String.optional
      attribute? :error_name, Types::String.optional
    end
  end
end
