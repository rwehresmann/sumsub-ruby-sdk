# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Sumsub::Parser do
  describe ".parse" do
    context "when is an error structure" do
      let(:json) { "{\"description\":\"Error analyzing file, unsupported format or corrupted file\",\"code\":400,\"correlationId\":\"req-5fd59b09-7f5e-41cd-a86b-38a4e6d57e08\",\"errorCode\":1004,\"errorName\":\"corrupted-file\"}" }

      it "parses into an Sumsub::Struct::ErrorResponse" do
        parsed = JSON.parse(json)
        error_response = Sumsub::Struct::ErrorResponse.new(
          description: parsed['description'],
          code: parsed['code'],
          correlation_id: parsed['correlationId'],
          error_code: parsed['errorCode'],
          error_name: parsed['errorName']
        )

        expect(described_class.parse(json)).to eq(error_response)
      end
    end

    context "when isn't an error structure" do
      let(:json) { "{\"applicantId\":\"das8adjd\"}" }

      it "returns a ruby hash" do
        parsed = JSON.parse(json)

        expect(described_class.parse(json)).to eq(parsed)
      end
    end
  end
end
