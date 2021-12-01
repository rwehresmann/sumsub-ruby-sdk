# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Sumsub::MessageSigner do
  describe ".sign" do
    let(:digest) { OpenSSL::Digest.new('sha256') }
    let(:time) { Time.now.to_i }
    let(:method) { 'POST' }
    let(:resource) { "applicants?levelName=basic-kyc" }

    before do
      Sumsub.configure do |config|
        config.secret_key = 'secret_key'
      end
    end

    context "when informing the body" do
      let(:body) { Sumsub::Struct::Applicant.new(externalUserId: '66').to_json }

      it "signs the message properly" do
        data = "#{time.to_s}#{method}/resources/#{resource}#{body}"

        expected_signature = OpenSSL::HMAC.hexdigest(digest, 'secret_key', data)
        signature = described_class.sign(
          time: time, 
          resource: resource, 
          method: method, 
          body: body
        )

        expect(signature).to eq expected_signature
      end
    end

    context "when not informing the body" do
      it "signs the message properly" do
        data = "#{time.to_s}#{method}/resources/#{resource}"

        expected_signature = OpenSSL::HMAC.hexdigest(digest, 'secret_key', data)
        signature = described_class.sign(
          time: time, 
          resource: resource, 
          method: method
        )

        expect(signature).to eq expected_signature
      end
    end
  end
end
