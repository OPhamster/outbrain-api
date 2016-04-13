require 'outbrain/api/report'

module Outbrain
  module Api
    class CampaignReport < Report
      PATH = 'performanceByCampaign'

      def self.path(marketer_id)
        "marketers/#{marketer_id}/#{PATH}"
      end

      def self.where(options = {})
        super(options.merge({path: self.path(options.fetch(:marketer_id))}))
      end
    end
  end
end
