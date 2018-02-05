require 'outbrain/api/publisher'
require 'outbrain/api/budget'
require 'outbrain/api/report'
require 'outbrain/api/campaign_report'
require 'outbrain/api/sites'

module Outbrain
  module Api
    class Marketer < Base
      coerce_key :blockedPublishers, Array[Publisher]
      coerce_key :blockedSites, Sites

      PATH = 'marketers'.freeze

      def self.all(request)
        request.all(PATH, as: self)
      end

      def self.create(*)
        raise EndpointNotAvialable, 'Marketers can not be created via the api.'
      end

      def budgets
        Budget.find_by(marketer_id: id)
      end

      # From/to needs to be supplied
      def campaign_reports(request, options = {})
        offset = 0
        limit = 1000
        response = []
        loop do
          options[:offset] = offset
          options[:limit] = limit
          page = CampaignReport.where(request, options.merge(marketer_id: id))
          response.concat(page)
          break if page.blank? || page.size < limit
          offset += limit
        end
        return response
      end

      # Returns all campaigns and handles pagination.
      # Valid options
      # includeArchived: Boolean
      # fetch: basic/all
      # extraFields=Locations,BlockedSites
      # Refer:
      # https://amplifyv01.docs.apiary.io/#reference/campaigns/campaigns-collection-via-marketer/list-all-campaigns-associated-with-a-marketer?console=1
      def campaigns(request, options = {})
        offset = 0
        limit = 1000
        response = []
        loop do
          options[:offset] = offset
          options[:limit] = limit
          page = Campaign.where(request, options.merge(marketer_id: id))
          response.concat(page)
          break if page.blank? || page.size < limit
          offset += limit
        end
        return response
      end
    end
  end
end
