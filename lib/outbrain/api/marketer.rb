require "outbrain/api/publisher"
require "outbrain/api/budget"

module Outbrain
  module Api
    class Marketer < Base
      coerce_key :blockedPublishers, Array[Publisher]

      PATH = 'marketers'

      def self.all
        Request.all(PATH, { as: self })
      end

      def self.create(*)
        raise EndpointNotAvialable.new('Marketers can not be created via the api.')
      end

      def budgets
        Budget.find_by(marketer_id: id)
      end
    end
  end
end
