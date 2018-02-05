module Outbrain
  class Config
    attr_reader :api
    attr_reader :api_version

    def initialize(api, api_version)
      @api = api
      @api_version = api_version
    end
  end
end
