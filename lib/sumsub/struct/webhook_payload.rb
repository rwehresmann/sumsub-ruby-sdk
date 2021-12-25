# frozen_string_literal: true

module Sumsub
  module Struct
    # https://developers.sumsub.com/api-reference/#webhook-payload-attributes
    class WebhookPayload < BaseStruct
      attribute :applicantId, Types::String
      attribute :inspectionId, Types::String
      attribute :correlationId, Types::String
      attribute :externalUserId, Types::String
      attribute :type, Types::String
      attribute :reviewStatus, Types::String
      attribute :createdAt, Types::String
      attribute? :applicantType, Types::String
      attribute? :reviewResult, Types::Instance(Sumsub::Struct::ReviewResult)
      attribute? :applicantMemberOf, Types::Array.of(Types::Hash)
      attribute? :videoIdentReviewStatus, Types::String
      attribute? :applicantActionId, Types::String
      attribute? :externalApplicantActionId, Types::String
      attribute :clientId, Types::String
    end
  end
end
