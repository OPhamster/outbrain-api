require 'outbrain/api/report'

module Outbrain
  module Api
    class PublisherReport < Report
      PATH = 'performanceByPublisher'
      def self.path(options)
        "campaigns/#{options.fetch(:campaign_id)}/#{PATH}/"
      end
    end
  end
end
