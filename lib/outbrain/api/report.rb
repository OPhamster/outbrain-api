module Outbrain
  module Api
    class Report < Base
      PATH = 'performanceByCampaign'

      def self.where(id, from, to)
        Request.where("marketers/#{id}/#{PATH}", {from: from, to: to}, { as: self, resource_name: 'details' })
      end
    end
  end
end
