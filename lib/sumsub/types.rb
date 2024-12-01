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
        :RESIDENCE_PERMIT,
        :UTILITY_BILL,
        :SELFIE,
        :VIDEO_SELFIE,
        :PROFILE_IMAGE,
        :ID_DOC_PHOTO,
        :AGREEMENT,
        :CONTRACT,
        :DRIVERS_TRANSLATION,
        :INVESTOR_DOC,
        :VEHICLE_REGISTRATION_CERTIFICATE,
        :INCOME_SOURCE, # Proof of income
        :PAYMENT_METHOD,
        :BANK_CARD,
        :COVID_VACCINATION_FORM,
        :OTHER,
        nil,
      )

    # https://developers.sumsub.com/api-reference/#request-metadata-body-part-fields
    IdDocSubTypes = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :FRONT_SIDE,
        :BACK_SIDE,
        nil,
      )

    # https://developers.sumsub.com/api-reference/#getting-verification-results
    ReviewAnswers = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :GREEN,
        :RED,
      )

    # https://developers.sumsub.com/api-reference/#getting-verification-results
    RejectLabels = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :FORCED_VERIFICATION,
        :LIVENESS_WITH_PHONE,
        :DEEPFAKE,
        :DOCUMENT_TEMPLATE,
        :LOW_QUALITY,
        :SPAM,
        :NOT_DOCUMENT,
        :SELFIE_MISMATCH,
        :ID_INVALID,
        :FOREIGNER,
        :DUPLICATE,
        :BAD_AVATAR,
        :WRONG_USER_REGION,
        :INCOMPLETE_DOCUMENT,
        :BLACKLIST,
        :UNSATISFACTORY_PHOTOS,
        :DOCUMENT_PAGE_MISSING,
        :DOCUMENT_DAMAGED,
        :REGULATIONS_VIOLATIONS,
        :INCONSISTENT_PROFILE,
        :PROBLEMATIC_APPLICANT_DATA,
        :ADDITIONAL_DOCUMENT_REQUIRED,
        :AGE_REQUIREMENT_MISMATCH,
        :EXPERIENCE_REQUIREMENT_MISMATCH,
        :CRIMINAL,
        :WRONG_ADDRESS,
        :GRAPHIC_EDITOR,
        :DOCUMENT_DEPRIVED,
        :COMPROMISED_PERSONS,
        :PEP,
        :ADVERSE_MEDIA,
        :FRAUDULENT_PATTERNS,
        :SANCTIONS,
        :NOT_ALL_CHECKS_COMPLETED,
        :FRONT_SIDE_MISSING,
        :BACK_SIDE_MISSING,
        :SCREENSHOTS,
        :BLACK_AND_WHITE,
        :INCOMPATIBLE_LANGUAGE,
        :EXPIRATION_DATE,
        :UNFILLED_ID,
        :BAD_SELFIE,
        :BAD_VIDEO_SELFIE,
        :BAD_FACE_MATCHING,
        :BAD_PROOF_OF_IDENTITY,
        :BAD_PROOF_OF_ADDRESS,
        :BAD_PROOF_OF_PAYMENT,
        :SELFIE_WITH_PAPER,
        :FRAUDULENT_LIVENESS,
        :OTHER,
        :REQUESTED_DATA_MISMATCH,
        :OK,
        :COMPANY_NOT_DEFINED_STRUCTURE,
        :COMPANY_NOT_DEFINED_BENEFICIARIES,
        :COMPANY_NOT_VALIDATED_BENEFICIARIES,
        :COMPANY_NOT_DEFINED_REPRESENTATIVES,
        :COMPANY_NOT_VALIDATED_REPRESENTATIVES,
      )

    # https://developers.sumsub.com/api-reference/#getting-verification-results
    ReviewRejectTypes = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :FINAL,
        :RETRY,
      )

    # https://developers.sumsub.com/api-reference/#webhook-types
    WebhookTypes = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :applicantReviewed,
        :applicantPending,
        :applicantCreated,
        :applicantOnHold,
        :applicantPersonalInfoChanged,
        :applicantPrechecked,
        :applicantDeleted,
        :videoIdentStatusChanged,
        :applicantReset,
        :applicantActionPending,
        :applicantActionReviewed,
        :applicantActionOnHold,
      )
  end
end
