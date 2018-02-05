module Outbrain
  module Api
    class Report < Base
      def self.resource_name
        'details'
      end

      def self.where(request, options = {})
        report_options = {
          as: self,
          resource_name: resource_name
        }
        request.where(path(options), options, report_options)
      end
    end
  end
end
