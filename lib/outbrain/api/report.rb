module Outbrain
  module Api
    class Report < Base
      def self.resource_name
        'details'
      end

      def self.where(options = {})
        report_options = {
          as: self,
          resource_name: resource_name,
        }
        Request.where(self.path(options), options, report_options)
      end
    end
  end
end
