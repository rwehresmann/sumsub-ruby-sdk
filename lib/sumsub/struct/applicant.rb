# frozen_string_literal: true

module Sumsub
  module Struct
    # https://developers.sumsub.com/api-reference/#request-body
    class Applicant < BaseStruct
      attribute :externalUserId, Types::Coercible::String

      attribute? :sourceKey, Types::String
      attribute? :email, Types::String
      attribute? :lang, Types::String
      attribute? :metadata, Types::Array.of(Types::Hash)
      attribute? :info, Types::Instance(Sumsub::Struct::Info)
      attribute? :fixedInfo, Types::Instance(Sumsub::Struct::Info)
    end
  end
end
