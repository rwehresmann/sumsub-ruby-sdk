# frozen_string_literal: true

RSpec.describe Sumsub::Request do
  let(:generic_json) { "{\"applicantId\":\"123456abc\"}" }

  before do
    Sumsub.configure do |config|
      config.token = 'token'
      config.secret_key = 'secret_key'
    end
  end

  describe "#create_applicant" do
    let(:lvl_name) { 'basic-kyc' }
    let(:applicant) do
      Sumsub::Struct::Applicant.new(
        externalUserId: 'appt23', 
        email: 'grivia@mail.com'
      )
    end

    it "calls the right resource with the right headers and body" do
      resource = "applicants?levelName=#{lvl_name}"

      headers = build_headers(
        resource,
        method: 'POST',
        content_type: 'application/json',
        accept: 'application/json',
        body: applicant.to_json
      )

      set_http_client_expects(
        headers,
        :post,
        "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
        args: { json: applicant }
      )

      described_class.new.create_applicant(lvl_name, applicant)
    end
  end

  describe "#get_applicant_detailed_status" do
    let(:applicant_id) { '123' }

    it "calls the right resource with the right headers and body" do
      resource = "applicants/#{applicant_id}/requiredIdDocsStatus"

      headers = build_headers(
        resource,
        method: 'GET',
        content_type: 'application/json',
        accept: 'application/json',
      )

      set_http_client_expects(
        headers,
        :get,
        "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
      )

      described_class.new.get_applicant_detailed_status(applicant_id)
    end
  end

  describe "#get_applicant_data" do
    let(:applicant_id) { '123' }

    context "when applicant id should be used as external user id" do
      it "calls the right resource with the right headers and body" do
        resource = "applicants/-;externalUserId=#{applicant_id}/one"

        headers = build_headers(
          resource,
          method: 'GET',
          content_type: 'application/json',
          accept: 'application/json',
        )

        set_http_client_expects(
          headers,
          :get,
          "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
        )

        described_class.new.get_applicant_data(applicant_id, as_external_user_id: true)
      end
    end

    context "when applicant id shouldn't be used as external user id" do
      it "calls the right resource with the right headers and body" do
        resource = "applicants/#{applicant_id}/one"

        headers = build_headers(
          resource,
          method: 'GET',
          content_type: 'application/json',
          accept: 'application/json',
        )

        set_http_client_expects(
          headers,
          :get,
          "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
        )

        described_class.new.get_applicant_data(applicant_id)
      end
    end
  end

  describe "#get_applicant_status" do
    let(:applicant_id) { '123' }

    it "calls the right resource with the right headers and body" do
      resource = "applicants/#{applicant_id}/status"

      headers = build_headers(
        resource,
        method: 'GET',
        content_type: 'application/json',
        accept: 'application/json',
      )

      set_http_client_expects(
        headers,
        :get,
        "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
      )

      described_class.new.get_applicant_status(applicant_id)
    end
  end

  describe "#request_applicant_check" do
    let(:applicant_id) { '123' }

    context "when informing reason" do
      let(:reason) { 'something' }

      it "calls the right resource with the right headers and body" do
        resource = "applicants/#{applicant_id}/status/pending?reason=#{reason}"
  
        headers = build_headers(
          resource,
          method: 'POST',
          content_type: 'application/json',
          accept: 'application/json',
        )
  
        set_http_client_expects(
          headers,
          :post,
          "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
        )
  
        described_class.new.request_applicant_check(applicant_id, reason: reason)
      end
    end

    context "when not informing reason" do
      it "calls the right resource with the right headers and body" do
        resource = "applicants/#{applicant_id}/status/pending?reason="
  
        headers = build_headers(
          resource,
          method: 'POST',
          content_type: 'application/json',
          accept: 'application/json',
        )
  
        set_http_client_expects(
          headers,
          :post,
          "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
        )
  
        described_class.new.request_applicant_check(applicant_id)
      end
    end
  end

  describe "#get_document_image" do
    let(:inspection_id) { '123' }
    let(:image_id) { '77' }

    it "calls the right resource with the right headers and body" do
      resource = "inspections/#{inspection_id}/resources/#{image_id}"

      headers = build_headers(
        resource,
        method: 'GET',
        content_type: 'application/json',
        accept: 'application/json',
      )

      set_http_client_expects(
        headers,
        :get,
        "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
      )

      described_class.new.get_document_image(inspection_id, image_id)
    end
  end

  describe "#reset_applicant" do
    let(:applicant_id) { '123' }

    it "calls the right resource with the right headers and body" do
      resource = "applicants/#{applicant_id}/reset"

      headers = build_headers(
        resource,
        method: 'POST',
        content_type: 'application/json',
        accept: 'application/json',
      )

      set_http_client_expects(
        headers,
        :post,
        "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
      )

      described_class.new.reset_applicant(applicant_id)
    end
  end

  describe "#change_applicant_top_level_info" do
    let(:applicant_new_values) { Sumsub::Struct::ApplicantUpdate.new(id: '99') }

    it "calls the right resource with the right headers and body" do
      resource = "applicants/"

      headers = build_headers(
        resource,
        method: 'PATCH',
        content_type: 'application/json',
        accept: 'application/json',
        body: applicant_new_values.to_json
      )

      set_http_client_expects(
        headers,
        :patch,
        "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
        args: { json: applicant_new_values }
      )

      described_class.new.change_applicant_top_level_info(applicant_new_values)
    end
  end

  describe "#get_access_token" do
    let(:user_id) { '123' }

    context "when ttl_in_seconds is informed" do
      let(:ttl_in_seconds) { 2000 }

      it "calls the right resource with the right headers and body" do
        resource = "accessTokens?userId=#{user_id}&ttlInSecs=#{ttl_in_seconds}&external_action_id="
  
        headers = build_headers(
          resource,
          method: 'POST',
          content_type: 'application/json',
          accept: 'application/json',
        )
  
        set_http_client_expects(
          headers,
          :post,
          "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
        )
  
        described_class.new.get_access_token(user_id, ttl_in_seconds: ttl_in_seconds)
      end
    end

    context "when external_action_id is informed" do
      let(:external_action_id) { 9999 }

      it "calls the right resource with the right headers and body" do
        resource = "accessTokens?userId=#{user_id}&ttlInSecs=&external_action_id=#{external_action_id}"
  
        headers = build_headers(
          resource,
          method: 'POST',
          content_type: 'application/json',
          accept: 'application/json',
        )
  
        set_http_client_expects(
          headers,
          :post,
          "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
        )
  
        described_class.new.get_access_token(user_id, external_action_id: external_action_id)
      end
    end

    context "when none optional arg is informed" do
      it "calls the right resource with the right headers and body" do
        resource = "accessTokens?userId=#{user_id}&ttlInSecs=&external_action_id="
  
        headers = build_headers(
          resource,
          method: 'POST',
          content_type: 'application/json',
          accept: 'application/json',
        )
  
        set_http_client_expects(
          headers,
          :post,
          "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
        )
  
        described_class.new.get_access_token(user_id)
      end
    end
  end

  describe "#verify_webhook_sender" do
    let(:webhook_secret_key) { 'mysecretkey' }
    let(:payload) { 'some text' }

    it "calls the right resource with the right headers and body" do
      resource = "inspectionCallbacks/testDigest?secretKey=#{webhook_secret_key}"

      headers = build_headers(
        resource,
        method: 'POST',
        content_type: 'text/plain',
        accept: 'text/plain',
        body: payload
      )

      set_http_client_expects(
        headers,
        :post,
        "#{Sumsub::Request::PRODUCTION_URL}/#{resource}",
        args: { body: payload }
      )

      described_class.new.verify_webhook_sender(webhook_secret_key, payload)
    end
  end

  def set_http_client_expects(
    headers, 
    method, 
    url, 
    args: {}, 
    response: "{\"applicantId\":\"123456abc\"}"
  )
    http_client = double('HTTP::Client')

    expect(HTTP).to receive(:headers).with(headers) { http_client }
    if args.empty?
      expect(http_client).to receive(method).with(url) { generic_json }
    else
      expect(http_client).to receive(method).with(url, args) { generic_json }
    end
  end

  def build_headers(
    resource, 
    method:, 
    content_type:, 
    accept:,
    body: nil
  )
    Timecop.freeze

    epoch_time = Time.now.to_i

    access_signature = Sumsub::MessageSigner.sign(
      time: epoch_time,
      resource: resource,
      method: method,
      body: body
    )

    {
      "X-App-Token": Sumsub.configuration.token,
      "X-App-Access-Sig": access_signature,
      "X-App-Access-Ts": epoch_time.to_s,
      "Accept": accept,
      "Content-Type": content_type
    }
  end
end