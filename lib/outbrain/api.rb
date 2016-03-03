require "outbrain/api/version"
require 'faraday'
require 'json'

module Outbrain
  HEADER_AUTH_KEY = 'OB-TOKEN-V1'

  module Api
  end

  class Connection
    attr_accessor :token, :user_name, :user_password, :connection, :api_version, :logging

    def initialize(args={})
      @token = args[:token] || args['token']
      @user_name = args[:user_name] || args['user_name']
      @user_password = args[:user_password] || args['user_password']
      @api_version = args[:api_version] || args['api_version'] || 'v0.1'
      @logging = args[:logging] || args['logging'] || true # (default right now)

      get_token! unless @token
      # should raise if not authenticated properly
    end

    # authenticates using basic auth to get token.
    # => http://docs.amplifyv01.apiary.io/#reference/authentications
    def get_token!
      @temp_connection = Faraday.new(:url => "https://api.outbrain.com") do |faraday|
        faraday.response :logger if logging
        faraday.adapter  Faraday.default_adapter
      end

      @temp_connection.basic_auth user_name, user_password
      response = @temp_connection.get("/amplify/#{api_version}/login")
      @token = JSON.parse(response.body)[HEADER_AUTH_KEY]
      # need to raise error here if token does not exist
    end

    def connection
      @connection ||= refresh_connection
    end

    def refresh_connection
      @connection = Faraday.new(:url => "https://api.outbrain.com") do |faraday|
        faraday.response :logger if @logging
        faraday.adapter  Faraday.default_adapter
        faraday.headers['Content-Type'] = 'application/json'
        faraday.headers[HEADER_AUTH_KEY] = token
      end
    end

    def marketers
      connection.get("/amplify/#{api_version}/marketers")
    end
  end
end
