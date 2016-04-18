module Outbrain
  module Api
    class Report < Base
      REPORT_PARAMETERS = [:from, :to, :limit, :offset, :sort]
      RESOURCE_NAME = 'details'

      def self.where(options = {})
        report_options = options.select{|option, v| REPORT_PARAMETERS.include?(option) && !v.nil?}        
        Request.where(options.fetch(:path), report_options, { as: self, resource_name: RESOURCE_NAME })
      end
    end
  end
end
