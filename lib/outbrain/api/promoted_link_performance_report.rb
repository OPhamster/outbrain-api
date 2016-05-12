require 'outbrain/api/report'

module Outbrain
  module Api
    class PromotedLinkPerformanceReport < Report
      PATH = 'performanceByPromotedLink'

      def self.path(options)
        "campaigns/#{options.fetch(:campaign_id)}/#{PATH}/"
      end
    end
  end
end
