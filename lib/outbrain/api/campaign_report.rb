require 'outbrain/api/report'

module Outbrain
  module Api
    class CampaignReport < Report
      PATH = 'campaigns'.freeze
      DEFAULT_OPTIONS = {
        includeArchived: true,
        includeConversionDetails: true
      }.freeze

      def self.path(options)
        "reports/marketers/#{options.fetch(:marketer_id)}/#{PATH}/"
      end

      # From, to fields need to be given
      def self.where(request, options = {})
        options = options.merge!(DEFAULT_OPTIONS) { |_k, v1, v2| v1 || v2 }
        super(request, options, as: self, resource_name: 'campaignReport')
      end
    end
  end
end
