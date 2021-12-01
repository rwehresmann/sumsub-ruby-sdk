# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Sumsub do
  it "has a version number" do
    expect(Sumsub::VERSION).to_not be_nil
  end

  describe ".error_response?" do
    it do 
      response = Sumsub::Struct::ErrorResponse.new(
        description: 'error',
        code: '123',
        correlation_id: '66'
      )
      is_error = described_class.error_response?(response)

      expect(is_error).to eq true 
    end

    it "is false when the response is just a string (json)" do
      is_error = described_class.error_response?('{}')

      expect(is_error).to eq false
    end
  end
end
