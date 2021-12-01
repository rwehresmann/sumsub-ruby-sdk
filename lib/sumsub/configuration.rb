# frozen_string_literal: true

module Sumsub
  class Configuration
    attr_accessor :token, :secret_key, :production

    def initialize
      @token = nil
      @secret_key = nil
      @production = true
    end
  end
end
