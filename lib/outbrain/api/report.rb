module Outbrain
  module Api
    class Report < Base
      def self.resource_name
        'details'
      end

      def self.where(request, options = {}, report_options = {})
        default_report_options = {
          as: self,
          resource_name: resource_name
        }
        report_options.merge!(default_report_options) { |_k, v1, v2| v1 || v2 }
        request.where(path(options), options, report_options)
      end
    end
  end
end
