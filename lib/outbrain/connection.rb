require 'faraday'
require 'json'

module Outbrain
  class Connection
    BASE = 'https://api.outbrain.com'
    DEFAULT_API_VERSION = 'v0.1'
    attr_accessor :token, :user_name, :user_password, :connection, :api_version, :logging, :base_url

    def initialize(args={})
      @token = args[:token] || args['token']
      @user_name = args[:user_name] || args['user_name']
      @user_password = args[:user_password] || args['user_password']
      @api_version = args[:api_version] || args['api_version'] || DEFAULT_API_VERSION
      @logging = (args.key?(:logging) || args.key?('logging')) ? (args[:logging] || args['logging']) : true # (default right now)
      @base_url = args[:base_url] || "#{BASE}/amplify/#{api_version}/"
      get_token! unless @token
      # should raise if not authenticated properly
    end

    def self.configure(params={})
      connection = new(params)
      Config.api = connection.api
      Config.api_version = connection.api_version
      connection
    end

    # authenticates using basic auth to get token.
    # => http://docs.amplifyv01.apiary.io/#reference/authentications
    def get_token!
      @temp_api = Faraday.new(:url => base_url) do |faraday|
        faraday.response :logger if logging
        faraday.adapter  Faraday.default_adapter
      end

      @temp_api.basic_auth user_name, user_password
      response = @temp_api.get("/login")
      @token = JSON.parse(response.body)[Outbrain::HEADER_AUTH_KEY]
      # need to raise error here if token does not exist
    end

    def api
      @api ||= refresh_api
    end

    def refresh_api
      @api = Faraday.new(:url => base_url) do |faraday|
        faraday.response :logger if logging
        faraday.adapter  Faraday.default_adapter
        faraday.headers['Content-Type'] = 'application/json'
        faraday.headers[Outbrain::HEADER_AUTH_KEY] = token
      end
    end
  end
end
