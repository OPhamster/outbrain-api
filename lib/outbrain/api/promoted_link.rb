require 'outbrain/api/report'

module Outbrain
  module Api
    class PromotedLink < Base
      PATH = "promotedLinks"
      RESOURCE_NAME = PATH
      
      def self.find(id)
          Request.find( PATH, id, { as: self })
      end

      def self.where(options)
        path = "campaigns/#{options.fetch(:campaign_id)}/#{PATH}"
        Request.where(path, options, as: self, resource_name: RESOURCE_NAME)
      end
    end
  end
end
