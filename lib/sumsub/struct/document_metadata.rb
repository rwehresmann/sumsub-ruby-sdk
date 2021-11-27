module Sumsub
  module Struct
    # https://developers.sumsub.com/api-reference/#request-metadata-body-part-fields
    class DocumentMetadata < BaseStruct
      attribute :idDocType, Types::IdDocTypes
      attribute :country, Types::String # https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3

      attribute? :idDocSubType, Types::IdDocSubType
      attribute? :firstName, Types::String
      attribute? :middleName, Types::String
      attribute? :lastName, Types::String
      attribute? :issuedDate, Types::String
      attribute? :validUntil, Types::String
      attribute? :number, Types::String
      attribute? :dob, Types::String
      attribute? :placeOfBirth, Types::String
    end
  end
end
