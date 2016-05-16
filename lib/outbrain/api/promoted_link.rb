require 'outbrain/api/report'

module Outbrain
  module Api
    class PromotedLink < Base
      PATH = "promotedLinks"
      RESOURCE_NAME = PATH

      def self.campaign_path(campaign_id)
        "campaigns/#{campaign_id}/#{PATH}"
      end

      def self.create(attributes)
        Request.create(campaign_path(attributes.delete(:campaign_id)),
          { as: self, attributes: attributes })
      end

      def self.find(id)
        Request.find( PATH, id, { as: self })
      end

      def self.where(options)
        Request.where(campaign_path(options.fetch(:campaign_id)),
          options, as: self, resource_name: RESOURCE_NAME)
      end

      def self.update(id, attributes)
        Request.update(PATH, id, {as: self, attributes: attributes, wrap_response: false })
      end
    end
  end
end
