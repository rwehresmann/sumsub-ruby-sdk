# frozen_string_literal: true

require 'http'
require 'types'

module Sumsub  
  require 'sumsub/configuration'
  require 'sumsub/request'
  require 'sumsub/struct/base_struct'
  require 'sumsub/struct/address'
  require 'sumsub/struct/info'
  require 'sumsub/struct/applicant'
  require 'sumsub/struct/document_metadata'
  require 'sumsub/version'

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
end
