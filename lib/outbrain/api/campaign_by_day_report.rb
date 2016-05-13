require 'outbrain/api/report'

module Outbrain
  module Api
    class CampaignByDayReport < Report
      PATH = 'performanceByDay'
      def self.path(options)
        "campaigns/#{options.fetch(:campaign_id)}/#{PATH}/"
      end
    end
  end
end
