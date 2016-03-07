require "outbrain/api/publisher"

module Outbrain
  module Api
    class Marketer < Base
      coerce_key :blockedPublishers, Array[Publisher]

      PATH = 'marketers'

      def initialize(attributes)
        attributes.each do |key, value|
          self.send("#{key}=", value)
        end
        self
      end

      def self.all
        Request.all(PATH, { as: self })
      end

      def self.create(*)
        raise EndpointNotAvialable.new('Marketers can not be created via the api.')
      end
    end
  end
end
