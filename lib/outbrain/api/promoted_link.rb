require 'outbrain/api/report'

module Outbrain
  module Api
    class PromotedLink < Report
      PATH="promotedLinks"

      def self.path(options)
        "campaigns/#{options.fetch(:campaign_id)}/promotedLinks"
      end

      def self.resource_name
        "promotedLinks"
      end
    end
  end
end
