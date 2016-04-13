require "outbrain/api/publisher"
require "outbrain/api/budget"
require "outbrain/api/report"

module Outbrain
  module Api
    class Marketer < Base
      coerce_key :blockedPublishers, Array[Publisher]

      PATH = 'marketers'

      def self.all
        Request.all(PATH, { as: self })
      end

      def self.create(*)
        raise EndpointNotAvialable.new('Marketers can not be created via the api.')
      end

      def budgets
        Budget.find_by(marketer_id: id)
      end

      def campaign_reports(from, to)
        CampaignReport.where(id, from, to)
      end

      class CampaignReport < Report; end
    end
  end
end
