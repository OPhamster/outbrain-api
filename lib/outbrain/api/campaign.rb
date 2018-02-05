module Outbrain
  module Api
    class Campaign < Base
      PATH = 'campaigns'.freeze
      RESOURCE_NAME = PATH
      DEFAULT_OPTIONS = { includeArchived: false,
                          fetch: 'all',
                          extraFields: 'Locations,BlockedSites',
                          limit: 1000 }.freeze
      # Valid options
      # marketer_id: required
      # limit: how many per page
      # offset: starting index (from 0)
      # includeArchived: Boolean
      # fetch: basic/all
      # extraFields=Locations,BlockedSites
      # Refer:
      # https://amplifyv01.docs.apiary.io/#reference/campaigns/campaigns-collection-via-marketer/list-all-campaigns-associated-with-a-marketer?console=1
      def self.where(request, options = {})
        raise 'Marketer id required' unless options.key?(:marketer_id)
        options.merge!(DEFAULT_OPTIONS) { |_k, v1, v2| v1 || v2 }
        request.where(marketer_path(options[:marketer_id]),
                      options,
                      as: self)
      end

      def self.marketer_path(marketer_id)
        "marketers/#{marketer_id}/#{PATH}"
      end

      def self.create(request, attributes)
        request.create(PATH, as: self, attributes: attributes)
      end

      def self.find(request, campaign_id)
        request.find(PATH, campaign_id, as: self)
      end

      def self.update(request, campaign_id, attributes)
        request.update(PATH, campaign_id, as: self, attributes: attributes)
      end

      # From/to param needs to supplied
      def promoted_link_reports(request, options = {})
        offset = 0
        limit = 50
        response = []
        loop do
          options[:offset] = offset
          options[:limit] = limit
          page = PromotedLinkReport.where(
            request, options.merge(campaign_id: id)
          ).promoted_link_reports.to_a
          response.concat(page)
          break if page.blank? || page.size < limit
          offset += limit
        end
        return response
      end

      def promoted_links(request, options = {})
        offset = 0
        limit = 50
        response = []
        loop do
          options[:offset] = offset
          options[:limit] = limit
          page = PromotedLink.where(request, options.merge(campaign_id: id))
                             .promoted_links.to_a
          response.concat(page)
          break if page.blank? || page.size < limit
          offset += limit
        end
        return response
      end
    end
  end
end
