require 'outbrain/api/report'

module Outbrain
  module Api
    class PromotedLink < Base
      PATH = 'promotedLinks'.freeze
      RESOURCE_NAME = PATH
      DEFAULT_OPTIONS = {
        enabled: true,
        statuses: 'APPROVED,PENDING,REJECTED',
        limit: 50,
        promotedLinkImageWidth: 100,
        promotedLinkImageHeight: 100
      }.freeze

      def self.campaign_path(campaign_id)
        "campaigns/#{campaign_id}/#{PATH}"
      end

      def self.create(request, attributes)
        request.create(campaign_path(attributes.delete(:campaign_id)),
                       as: self, attributes: attributes)
      end

      def self.find(request, id)
        request.find(PATH, id, as: self)
      end

      # Refer to
      # https://amplifyv01.docs.apiary.io/#reference/promotedlinks/promotedlinks-collection/list-promotedlinks-for-campaign
      # Options can be one of:
      # enabled:true/false
      # statuses=APPROVED,PENDING,REJECTED
      # limit=limit
      # offset=offset
      # sort=sort
      # promotedLinkImageWidth=promotedLinkImageWidth
      # promotedLinkImageHeight=promotedLinkImageHeight
      def self.where(request, options)
        raise 'Campaign id required' unless options.key?(:campaign_id)
        options.merge!(DEFAULT_OPTIONS) { |_k, v1, v2| v1 || v2 }
        path = campaign_path(options.fetch(:campaign_id))
        options.delete(:campaign_id)
        request.where(path, options, as: self)
      end

      def self.update(request, id, attributes)
        request.update(
          PATH, id, as: self, attributes: attributes, wrap_response: false
        )
      end
    end
  end
end
