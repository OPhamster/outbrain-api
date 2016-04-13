module Outbrain
  module Api
    class Report < Base
      def self.where(path, from, to)
        Request.where(path, {from: from, to: to}, { as: self, resource_name: 'details' })
      end
    end
  end
end
