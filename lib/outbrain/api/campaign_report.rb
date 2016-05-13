require 'outbrain/api/report'

module Outbrain
  module Api
    class CampaignReport < Report
      PATH = 'performanceByCampaign'
      def self.path(options)
        "marketers/#{options.fetch(:marketer_id)}/#{PATH}/"
      end
    end
  end
end
