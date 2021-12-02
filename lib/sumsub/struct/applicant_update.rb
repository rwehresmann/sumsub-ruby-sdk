# frozen_string_literal: true

module Sumsub
  module Struct
    # https://developers.sumsub.com/api-reference/#request-body-2
    class ApplicantUpdate < BaseStruct
      attribute :id, Types::String
      attribute? :externalUserId, Types::String
      attribute? :email, Types::String
      attribute? :phone, Types::String
      attribute? :sourceKey, Types::String
      attribute? :type, Types::String
      attribute? :lang, Types::String
      attribute? :questionnaires, Types::Array.of(Types::Hash)
      attribute? :metadata, Types::Array.of(Types::Hash)
      attribute? :deleted, Types::Bool
    end
  end
end
