require 'outbrain/api/report'

module Outbrain
  module Api
    class PromotedLinkReport < Report
      PATH="promotedLinks"

      def self.path(options)
        "campaigns/#{options.fetch(:campaign_id)}/#{PATH}"
      end

      def self.resource_name
        "promotedLinks"
      end

      def self.find(id, options)
          Request.find(PATH, id, { as: self })
      end
    end
  end
end
