module Sumsub
  module Struct
    # https://developers.sumsub.com/api-reference/#fixedinfo-and-info-attributes
    class Info < BaseStruct
      attribute? :firstName, Types::String
      attribute? :lastName, Types::String
      attribute? :middleName, Types::String
      attribute? :firstNameEn, Types::String
      attribute? :lastNameEn, Types::String
      attribute? :middleNameEn, Types::String
      attribute? :legalName, Types::String
      attribute? :gender, Types::String
      attribute? :dob, Types::String
      attribute? :placeOfBirth, Types::String
      attribute? :countryOfBirth, Types::String
      attribute? :stateOfBirth, Types::String
      attribute? :country, Types::String
      attribute? :nationality, Types::String
      attribute? :phone, Types::String     
      attribute? :addresses, Types::Array.of(Sumsub::Struct::Address)
    end
  end
end
