# frozen_string_literal: true

module Sumsub
  module Struct
    # https://developers.sumsub.com/api-reference/#request-body-4
    class ReviewResult < BaseStruct
      attribute :reviewAnswer, Types::ReviewAnswers
      attribute :rejectLabels, Types::Array.of(Types::RejectLabels)
      attribute? :reviewRejectType, Types::ReviewRejectTypes
      attribute? :clientComment, Types::String
      attribute? :moderationComment, Types::String
    end
  end
end
