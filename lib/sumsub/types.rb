# frozen_string_literal: true

module Sumsub
  module Types
    include Dry.Types()

    # https://developers.sumsub.com/api-reference/#supported-document-types
    IdDocTypes = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :ID_CARD,
        :PASSPORT,
        :DRIVERS, # Driving license
        :BANK_CARD,
        :UTILITY_BILL,
        :BANK_STATEMENT,
        :SELFIE,
        :VIDEO_SELFIE,
        :PROFILE_IMAGE,
        :ID_DOC_PHOTO,
        :AGREEMENT,
        :CONTRACT,
        :RESIDENCE_PERMIT,
        :EMPLOYMENT_CERTIFICATE,
        :DRIVERS_TRANSLATION,
        :INVESTOR_DOC,
        :VEHICLE_REGISTRATION_CERTIFICATE,
        :INCOME_SOURCE, # Proof of income
        :PAYMENT_METHOD,
        :OTHER,
        nil,
      )

    IdDocSubType = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :FRONT_SIDE,
        :BACK_SIDE,
      )
  end
end
