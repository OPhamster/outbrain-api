module Outbrain
  class Config
    BASE = Outbrain::Connection::BASE

    @@api = nil
    @@api_version = nil

    def self.api=(api)
      @@api = api
    end

    def self.api_version=(api_version)
      @@api_version = api_version
    end

    private
    def self.api
      @@api
    end

    def api
      self.class.api
    end

    def api_version
      self.class.api_version
    end

    def self.api_version
      @@api_version
    end
  end
end
