# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Sumsub::WebhookSender do
  describe ".get_payload" do
    let(:params) do
      {
        applicantId: '99112f57c8321e000114e4d6',
        inspectionId: '99112f57c8321e000114e4d7',
        applicantType: 'individual',
        correlationId: 'req-b3a4d8f0-653f-4b7b-ba22-a582bf7fc78b',
        externalUserId: 'dash-c3210c32-4b8f-4407-8854-861a376565dc',
        type: 'applicantReviewed',
        reviewResult: {
          reviewAnswer: 'GREEN',
          rejectLabels: [
            'NOT_DOCUMENT'
          ],
          reviewRejectType: 'RETRY'
        },
        reviewStatus: 'completed',
        createdAt: '2021-12-16 20:14:03+0000',
        clientId: 'website.com_27055'
      }
    end

    it "checks the payload properly" do
      expected_payload = "{\n  \"applicantId\" : \"99112f57c8321e000114e4d6\",\n  \"inspectionId\" : \"99112f57c8321e000114e4d7\",\n  \"applicantType\" : \"individual\",\n  \"correlationId\" : \"req-b3a4d8f0-653f-4b7b-ba22-a582bf7fc78b\",\n  \"externalUserId\" : \"dash-c3210c32-4b8f-4407-8854-861a376565dc\",\n  \"type\" : \"applicantReviewed\",\n  \"reviewResult\" : {\n    \"reviewAnswer\" : \"GREEN\",\n    \"rejectLabels\" : [ \"NOT_DOCUMENT\" ],\n    \"reviewRejectType\" : \"RETRY\"\n  },\n  \"reviewStatus\" : \"completed\",\n  \"createdAt\" : \"2021-12-16 20:14:03+0000\",\n  \"clientId\" : \"website.com_27055\"\n}"

      payload = described_class.get_payload(params)

      expect(payload).to eq expected_payload
    end
  end
end
