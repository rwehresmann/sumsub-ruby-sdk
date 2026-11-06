# frozen_string_literal: true

module Sumsub
  module Types
    include Dry.Types()

    # https://docs.sumsub.com/reference/add-verification-documents#supported-document-types
    IdDocTypes = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :AGREEMENT,
        :ARBITRARY_DOC,
        :BANK_CARD,
        :CONTRACT,
        :COVID_VACCINATION_FORM,
        :DRIVERS, # Driving license
        :DRIVERS_TRANSLATION,
        :FILE_ATTACHMENT,
        :ID_CARD,
        :ID_DOC_PHOTO,
        :INCOME_SOURCE, # Proof of income
        :INVESTOR_DOC,
        :PASSPORT,
        :PAYMENT_SOURCE,
        :PROFILE_IMAGE,
        :RESIDENCE_PERMIT,
        :SELFIE,
        :UTILITY_BILL, # Proof of address document
        :UTILITY_BILL2, # Second proof of address document
        :VEHICLE_REGISTRATION_CERTIFICATE,
        :VIDEO_SELFIE,
        :OTHER,
        nil,
      )

    # https://docs.sumsub.com/reference/add-verification-documents
    IdDocSubTypes = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :FRONT_SIDE,
        :BACK_SIDE,
        nil,
      )

    # https://docs.sumsub.com/docs/receive-and-interpret-results-via-api
    ReviewAnswers = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :GREEN,
        :RED,
      )

    # https://docs.sumsub.com/docs/receive-and-interpret-results-via-api#rejected-labels
    RejectedLabels = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :ADVERSE_MEDIA,
        :AGE_REQUIREMENT_MISMATCH,
        :BLOCKLIST,
        :CHECK_UNAVAILABLE,
        :COMPROMISED_PERSONS,
        :CRIMINAL,
        :DB_DATA_MISMATCH,
        :DB_DATA_NOT_FOUND,
        :DOCUMENT_TEMPLATE,
        :DUPLICATE,
        :EXPERIENCE_REQUIREMENT_MISMATCH,
        :EXTERNAL_DECISION_REJECTION,
        :FORGERY,
        :FRAUDULENT_LIVENESS,
        :FRAUDULENT_PATTERNS,
        :HIGH_RISK,
        :INCONSISTENT_PROFILE,
        :PEP,
        :REGULATIONS_VIOLATIONS,
        :SANCTIONS,
        :SELFIE_MISMATCH,
        :SPAM,
        :NOT_DOCUMENT,
        :THIRD_PARTY_INVOLVED,
        :UNSUPPORTED_LANGUAGE,
        :WRONG_USER_REGION,
        :SUSPICIOUS_PATTERNS,
      )

    # https://docs.sumsub.com/docs/receive-and-interpret-results-via-api#resubmission-requested-labels
    ResubmissionRequestedLabels = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :APPLICANT_INTERRUPTED_INTERVIEW,
        :ADDITIONAL_DOCUMENT_REQUIRED,
        :BACK_SIDE_MISSING,
        :BAD_AVATAR,
        :BAD_FACE_MATCHING,
        :BAD_PROOF_OF_ADDRESS,
        :BAD_PROOF_OF_IDENTITY,
        :BAD_PROOF_OF_PAYMENT,
        :BAD_SELFIE,
        :BAD_VIDEO_SELFIE,
        :BLACK_AND_WHITE,
        :COMPANY_NOT_DEFINED_BENEFICIARIES,
        :COMPANY_NOT_DEFINED_REPRESENTATIVES,
        :COMPANY_NOT_DEFINED_STRUCTURE,
        :COMPANY_NOT_VALIDATED_BENEFICIARIES,
        :COMPANY_NOT_VALIDATED_REPRESENTATIVES,
        :CONNECTION_INTERRUPTED,
        :DIGITAL_DOCUMENT,
        :DOCUMENT_DEPRIVED,
        :DOCUMENT_DAMAGED,
        :DOCUMENT_MISSING,
        :DOCUMENT_PAGE_MISSING,
        :EXPIRATION_DATE,
        :FRONT_SIDE_MISSING,
        :GRAPHIC_EDITOR,
        :ID_INVALID,
        :INCOMPATIBLE_LANGUAGE,
        :INCOMPLETE_DOCUMENT,
        :INCORRECT_SOCIAL_NUMBER,
        :PROBLEMATIC_APPLICANT_DATA,
        :REQUESTED_DATA_MISMATCH,
        :SELFIE_WITH_PAPER,
        :LOW_QUALITY,
        :NOT_ALL_CHECKS_COMPLETED,
        :SCREENSHOTS,
        :SUSPICIOUS_DOCUMENT,
        :UNFILLED_ID,
        :UNSATISFACTORY_PHOTOS,
        :UNSUITABLE_ENV,
        :WRONG_ADDRESS,
      )

    # https://docs.sumsub.com/docs/receive-and-interpret-results-via-api#understand-rejection
    RejectLabels = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        *RejectedLabels.values,
        *ResubmissionRequestedLabels.values
      )

    # https://docs.sumsub.com/docs/receive-and-interpret-results-via-api
    ReviewRejectTypes = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :FINAL,
        :RETRY,
      )

    # https://docs.sumsub.com/docs/user-verification-webhooks
    WebhookTypes = Types::Strict::Symbol
      .constructor(&:to_sym)
      .enum(
        :applicantCreated,
        :applicantPending,
        :applicantReviewed,
        :applicantOnHold,
        :applicantActionPending,
        :applicantActionReviewed,
        :applicantActionOnHold,
        :applicantPersonalInfoChanged,
        :applicantTagsChanged,
        :applicantActivated,
        :applicantDeactivated,
        :applicantDeleted,
        :applicantReset,
        :applicantPrechecked,
        :applicantLevelChanged,
        :applicantWorkflowCompleted,
        :applicantWorkflowFailed,
        :videoIdentStatusChanged,
        :videoIdentCompositionCompleted,
        :applicantAwaitingService,
        :applicantAwaitingUser,
      )
  end
end
