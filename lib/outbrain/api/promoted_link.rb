require 'outbrain/api/report'

module Outbrain
  module Api
    class PromotedLink < Base
      PATH = "promotedLinks"

      def self.find(id)
          Request.find( PATH, id, { as: self })
      end
    end
  end
end
