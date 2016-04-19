require 'outbrain/api/report'

module Outbrain
  module Api
    class PublisherReport < Report
      PATH = 'performanceByPublisher'

      def self.path(campaign_id)
        "campaigns/#{campaign_id}/#{PATH}"
      end

      def self.where(options = {})
        super(options.merge({path: self.path(options.fetch(:campaign_id))}))
      end
    end
  end
end

