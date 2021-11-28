# frozen_string_literal: true

module Sumsub
  module Struct
    # https://developers.sumsub.com/api-reference/#addresses-elements-fields
    class Address < BaseStruct
      attribute? :country, Types::String
      attribute? :postCode, Types::String
      attribute? :town, Types::String
      attribute? :street, Types::String
      attribute? :subStreet, Types::String
      attribute? :state, Types::String
      attribute? :buildingName, Types::String
      attribute? :flatNumber, Types::String
      attribute? :buildingNumber, Types::String
      attribute? :startDate, Types::String
      attribute? :endDate, Types::String    
    end
  end
end
