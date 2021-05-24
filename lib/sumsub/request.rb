module Sumsub
  class Request
    PRODUCTION_URL = "https://api.sumsub.com/resources"
    TEST_URL = "https://test-api.sumsub.com/resources"

    def initialize(
      token: Sumsub.configuration.token, 
      secret_key: Sumsub.configuration.secret_key,
      production: Sumsub.configuration.production
    )
      @token = token
      @secret_key = secret_key
      @url = production ? PRODUCTION_URL : TEST_URL
    end

    # https://developers.sumsub.com/api-reference/#creating-an-applicant
    def create_applicant(lvl_name, applicant)
      resource = "applicants?levelName=#{lvl_name}"
      headers = build_header(resource, body: applicant.to_json)
      response = HTTP.headers(headers)
                     .post("#{@url}/#{resource}", json: applicant)
      
      parse_response(response)
    end

    # https://developers.sumsub.com/api-reference/#adding-an-id-document
    # To understand how the body was build manually bellow: 
    # https://roytuts.com/boundary-in-multipart-form-data/
    def add_id_doc(applicant_id, metadata, file_name: nil)
      resource = "applicants/#{applicant_id}/info/idDoc"

      boundary = '----XYZ'

      body = + '--' + boundary + "\r\n"
      body += 'Content-Disposition: form-data; name="metadata"'
      body += "\r\nContent-type: application/json; charset=utf-8\r\n\r\n"
      body += metadata.to_json
      body += "\r\n"
      body += '--' + boundary

      if file_name
        content = File.read(file_name)

        body += "\r\n" 
        body += 'Content-Disposition: form-data; name="content"; filename="image.png"'
        body += "\r\nContent-type: image/png; charset=utf-8\r\n\r\n"
        body += content + "\r\n"
        body += '--' + boundary + '--'
      else
        body += '--'
      end

      headers = build_header(
        resource, 
        body: body, 
        content_type: 'multipart/form-data; boundary=' + boundary
      ).merge({ "X-Return-Doc-Warnings": true })
      response = HTTP.headers(headers)
                     .post("#{@url}/#{resource}", body: body)
    
      parse_response(response)
    end

    # https://developers.sumsub.com/api-reference/#getting-applicant-status-api
    def get_applicant_status(applicant_id)
      resource = "applicants/#{applicant_id}/requiredIdDocsStatus"
      headers = build_header(resource, method: 'GET')
      response = HTTP.headers(headers)
                     .get("#{@url}/#{resource}")

      parse_response(response)
    end
    
    # https://developers.sumsub.com/api-reference/#getting-applicant-data
    def get_applicant_data(applicant_id, external_user_id: false) 
      resource = external_user_id ? 
        "applicants/-;externalUserId=#{applicant_id}/one" : 
        "applicants/#{applicant_id}/one"
      headers = build_header(resource, method: 'GET')
      response = HTTP.headers(headers)
                     .get("#{@url}/#{resource}")

      parse_response(response)
    end

    # https://developers.sumsub.com/api-reference/#getting-applicant-status-sdk
    def get_applicant_status(applicant_id) 
      resource = "applicants/#{applicant_id}/status"
      headers = build_header(resource, method: 'GET')
      response = HTTP.headers(headers)
                     .get("#{@url}/#{resource}")
      
      parse_response(response)
    end

    # https://developers.sumsub.com/api-reference/#requesting-an-applicant-check
    def request_applicant_check(applicant_id, reason: nil)
      resource = "applicants/#{applicant_id}/status/pending?reason=#{reason}"
      headers = build_header(resource)
      response = HTTP.headers(headers)
                     .post("#{@url}/#{resource}")
      
      parse_response(response)
    end

    # https://developers.sumsub.com/api-reference/#getting-document-images
    def get_document_image(inspection_id, image_id)
      resource = "inspections/#{inspection_id}/resources/#{image_id}"
      headers = build_header(resource, method: 'GET')
      response = HTTP.headers(headers)
                     .get("#{@url}/#{resource}")

      parse_response(response)
    end

    # https://developers.sumsub.com/api-reference/#resetting-an-applicant
    def reset_applicant(applicant_id)
      resource = "applicants/#{applicant_id}/reset"
      headers = build_header(resource)
      response = HTTP.headers(headers)
                     .post("#{@url}/#{resource}")

      parse_response(response)
    end

    # https://developers.sumsub.com/api-reference/#changing-top-level-info
    # Sumsub::Struct::ApplicantUpdate can be used in order to inform applicant_new_values.
    def change_applicant_top_level_info(applicant_new_values)
      resource = "applicants/"
      headers = build_header(resource, method: 'PATCH', body: applicant_new_values.to_json)
      response = HTTP.headers(headers)
                     .post("#{@url}/#{resource}", json: applicant_new_values)

      parse_response(response)
    end

    # https://developers.sumsub.com/api-reference/#access-tokens-for-sdks
    def get_access_token(user_id, ttl_in_seconds: nil, external_action_id: nil)
      resource = "accessTokens?userId=#{user_id}&ttlInSecs=#{ttl_in_seconds}&external_action_id=#{external_action_id}"
      headers = build_header(resource, method: 'POST')
      response = HTTP.headers(headers)
                     .post("#{@url}/#{resource}")

      parse_response(response)
    end

    # https://developers.sumsub.com/api-reference/#verifying-webhook-sender
    def verify_webhook_sender(webhook_secret_key, payload)
      resource = "inspectionCallbacks/testDigest?secretKey=#{webhook_secret_key}"
      headers = build_header(
        resource, 
        method: 'POST', 
        content_type: 'text/plain',
        accept: 'text/plain',
        body: payload.to_json
      )
      response = HTTP.headers(headers)
                     .post("#{@url}/#{resource}", json: payload)

      parse_response(response)
    end

    private

    # More infos about the required header and the signing strategy:
    # https://developers.sumsub.com/api-reference/#app-tokens
    def build_header(
      resource, 
      body: nil, 
      method: 'POST', 
      content_type: 'application/json', 
      accept: 'application/json'
    )
      epoch_time = Time.now.to_i
      access_signature = Sumsub::MessageSigner.sign(
        time: epoch_time, 
        resource: resource, 
        body: body, 
        method: method,
      )

      {
        "X-App-Token": @token.encode("UTF-8"),
        "X-App-Access-Sig": access_signature.encode("UTF-8"),
        "X-App-Access-Ts": epoch_time.to_s.encode("UTF-8"),
        "Accept": accept,
        "Content-Type": content_type
      }
    end

    def parse_response(response)
      JSON.parse(response.to_s)
    end
  end
end


