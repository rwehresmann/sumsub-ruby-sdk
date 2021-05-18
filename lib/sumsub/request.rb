module Sumsub
  class Request
    URL = "https://api.sumsub.com/resources"

    def initialize(token, secret_key)
      @token = token
      @secret_key = secret_key
    end

    # https://developers.sumsub.com/api-reference/#creating-an-applicant
    def create_applicant(lvl_name, body)
      resource = "applicants?levelName=#{lvl_name}"
      headers = build_header(resource, body: body.to_json)

      HTTP
        .headers(headers)
        .post("#{URL}/#{resource}", json: body)
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

      HTTP
        .headers(headers)
        .post("#{URL}/#{resource}", body: body)
    end

    
    private

    # More infos about the required header and the signing strategy:
    # https://developers.sumsub.com/api-reference/#app-tokens
    def build_header(resource, body: nil, method: 'POST', content_type: 'application/json')
      epoch_time = Time.now.to_i

      access_signature = sign_message(epoch_time, resource, body, method)

      {
        "X-App-Token": "#{@token.encode("UTF-8")}",
        "X-App-Access-Sig": "#{access_signature.encode("UTF-8")}",
        "X-App-Access-Ts": "#{epoch_time.to_s.encode("UTF-8")}",
        "Accept": "application/json",
        "Content-Type": "#{content_type}"
      }
    end

    def sign_message(time, resource, body, method='POST')
      key = @secret_key
      data = time.to_s + method + '/resources/' + resource + body.to_s
      digest = OpenSSL::Digest.new('sha256')

      OpenSSL::HMAC.hexdigest(digest, key, data)
    end

  end
end


