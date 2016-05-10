module Outbrain
  module Api
    class Campaign < Base
      PATH = 'campaigns'

      def self.create(attributes)
        Request.create(PATH, { as: self, attributes: attributes })
      end

      def self.find(campaign_id)
        Request.find(PATH, campaign_id, { as: self })
      end

      def self.update(campaign_id, attributes)
        Request.update(PATH, campaign_id, {as: self, attributes: attributes })
      end
    end
  end
end
