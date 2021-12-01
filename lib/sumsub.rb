# frozen_string_literal: true

########
# Gems #
########

require 'http'
require 'mime/types'
require 'dry-struct'

################
# Own requires #
################

require 'sumsub/version'

require 'sumsub/types'
require 'sumsub/message_signer'
require 'sumsub/configuration'
require 'sumsub/parser'
require 'sumsub/request'
require 'sumsub/struct/base_struct'
require 'sumsub/struct/error_response'
require 'sumsub/struct/address'
require 'sumsub/struct/info'
require 'sumsub/struct/applicant'
require 'sumsub/struct/applicant_update'
require 'sumsub/struct/document_metadata'

module Sumsub
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.error_response?(response)
    response.class == Sumsub::Struct::ErrorResponse
  end
end
