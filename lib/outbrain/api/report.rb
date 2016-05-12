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
          meta_resource_names: options.delete(:meta_resource_names) || []
        }
        Request.where(self.path(options), options, report_options)
      end
    end
  end
end
