module Outbrain
  module Api
    class Report < Base
      REPORT_PARAMETERS = [:from, :to, :limit, :offset, :sort]
      RESOURCE_NAME = 'details'

      def self.where(options = {})
        report_query = options.select{|option, v| REPORT_PARAMETERS.include?(option) && !v.nil?}        
        report_options = { as: self, resource_name: RESOURCE_NAME, meta_resource_names: options.fetch(:meta_resource_names, []) }
        Request.where(options.fetch(:path), report_query, report_options)
      end
    end
  end
end
