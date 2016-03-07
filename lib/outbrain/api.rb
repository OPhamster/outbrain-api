require "outbrain/api/version"

# configs
require "outbrain/connection"
require "outbrain/config"
require "outbrain/base"
require "outbrain/request"

# models
# Dir["outbrain/api/*.rb"].each {|file| require file }:w

require "outbrain/api/marketer"

module Outbrain
  HEADER_AUTH_KEY = 'OB-TOKEN-V1'

  module Api
  end
end
