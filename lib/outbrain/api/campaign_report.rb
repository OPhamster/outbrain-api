require 'outbrain/api/report'

module Outbrain
  module Api
    class CampaignReport < Report
      PATH = 'performanceByCampaign'

      def self.path(id)
        "marketers/#{id}/#{PATH}"
      end

      def self.where(id, from, to)
        super(self.path(id), from, to)
      end
    end
  end
end
