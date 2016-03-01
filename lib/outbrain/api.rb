require "outbrain/api/version"

module Outbrain

  class Api
  end

  class OAuth
    attr_accessor :token, :user_name, :user_password
    def initialize(args={})
      @token = args[:token] || args['token']
      @user_name = args[:user_name] || args['user_name']
      @user_passwrod = args[:user_password] || args['user_password']
      get_token! unless @token
    end

    # authenticates using basic auth to get token.
    # => http://docs.amplifyv01.apiary.io/#reference/authentications
    def get_token!

    end
  end
end
